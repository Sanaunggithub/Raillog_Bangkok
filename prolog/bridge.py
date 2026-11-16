"""bridge.py - Python <-> Prolog bridge for the Bangkok rail route planner.

Public API
----------
stations()                       -> {station_id: {...}}
find_route(mode, start, goal)    -> {"route", "minutes", "transfers", "steps"}

Errors (all subclasses of RouteError):
    UnknownStation, UnknownMode, SameStation, NoRouteFound

Threading: pyswip engines are bound to the thread that created them and
Streamlit runs each session in its own thread. Every Prolog call is therefore
executed on ONE dedicated worker thread, which also serialises access to the
global transfer_penalty/1 that plan(fewest_transfers, ...) modifies.
"""
from __future__ import annotations

import re
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from pyswip import Prolog

try:  # location of PrologError differs between pyswip versions
    from pyswip.prolog import PrologError
except ImportError:  # pragma: no cover
    try:
        from pyswip import PrologError
    except ImportError:
        PrologError = Exception

PLANNER_FILE = Path(__file__).resolve().parent / "planner.pl"  # bridge.py lives in prolog/

MODES = ("fastest", "fewest_transfers", "fewest_stations")

_ID_RE = re.compile(r"^[a-z][a-z0-9_]*$")


# --------------------------------------------------------------- errors ----
class RouteError(Exception):
    """Base class for all expected routing problems."""


class UnknownStation(RouteError):
    pass


class UnknownMode(RouteError):
    pass


class SameStation(RouteError):
    pass


class NoRouteFound(RouteError):
    pass


# ------------------------------------------------------- prolog thread -----
_EXECUTOR = ThreadPoolExecutor(max_workers=1, thread_name_prefix="prolog")
_PROLOG: Prolog | None = None
_STATIONS: dict[str, dict] | None = None


def _run(fn, *args):
    """Run fn on the single Prolog worker thread and return its result."""
    return _EXECUTOR.submit(fn, *args).result()


def _engine() -> Prolog:
    global _PROLOG
    if _PROLOG is None:
        if not PLANNER_FILE.is_file():
            raise FileNotFoundError(f"planner.pl not found at {PLANNER_FILE}")
        prolog = Prolog()
        prolog.consult(PLANNER_FILE.as_posix())
        _PROLOG = prolog
    return _PROLOG


# ------------------------------------------------------ term conversion ----
def _py(term):
    """Convert a pyswip term into plain Python data.

    Atoms/strings -> str, numbers unchanged, lists -> list,
    compound terms -> (name, [args]) tuple.
    """
    if isinstance(term, bytes):
        return term.decode("utf-8", errors="replace")
    if isinstance(term, (int, float, str)):
        return term
    if isinstance(term, (list, tuple)):
        return [_py(t) for t in term]
    if hasattr(term, "args") and hasattr(term, "name"):
        return (_py(term.name), [_py(a) for a in term.args])
    if hasattr(term, "value"):  # pyswip Atom
        return _py(term.value)
    return str(term)


_COMPOUND_RE = re.compile(r"\s*(\w+)\((.*)\)\s*$", re.DOTALL)


def _step(term) -> dict:
    value = _py(term)
    if isinstance(value, str):
        # some pyswip versions return compound terms as text: "ride(a,b,1.0,2.0)"
        match = _COMPOUND_RE.match(value)
        if not match:
            raise ValueError(f"Cannot parse step term: {term!r}")
        args = [a.strip().strip("'") for a in match.group(2).split(",")]
        value = (match.group(1), args)
    if not (isinstance(value, tuple) and len(value) == 2):
        raise ValueError(f"Unexpected step term: {term!r}")
    name, args = value
    if name == "ride":
        frm, to, km, minutes = args
        return {"type": "ride", "from": frm, "to": to,
                "km": float(km), "min": float(minutes)}
    if name == "transfer":
        frm, to, minutes = args
        return {"type": "transfer", "from": frm, "to": to,
                "min": float(minutes)}
    raise ValueError(f"Unexpected step term: {term!r}")


# ------------------------------------------------------------ stations -----
def _load_stations() -> dict[str, dict]:
    global _STATIONS
    if _STATIONS is None:
        prolog = _engine()
        result: dict[str, dict] = {}
        query = ("station(Id, NameEn, NameTh, Operator, Line, Lat, Lng)")
        for row in prolog.query(query):  # exhaust the generator fully
            sid = _py(row["Id"])
            result[sid] = {
                "id": sid,
                "name_en": _py(row["NameEn"]),
                "name_th": _py(row["NameTh"]),
                "operator": _py(row["Operator"]),
                "line": _py(row["Line"]),
                "lat": float(row["Lat"]),
                "lng": float(row["Lng"]),
            }
        _STATIONS = result
    return _STATIONS


def stations() -> dict[str, dict]:
    """All stations keyed by id (loaded once from station/7)."""
    return _run(_load_stations)


# ---------------------------------------------------------- find_route -----
def _query_route(mode: str, start: str, goal: str):
    prolog = _engine()
    # mode/start/goal were validated against fixed sets, so they are safe atoms.
    goal_text = (f"plan({mode}, {start}, {goal}, Route, Minutes, Transfers), "
                 f"route_steps(Route, Steps)")
    try:
        # maxresult=1 makes pyswip close the query (no dangling choicepoints)
        rows = list(prolog.query(goal_text, maxresult=1))
    except PrologError as exc:
        text = str(exc)
        if "existence_error" in text:
            raise UnknownStation(text) from exc
        if "domain_error" in text:
            raise UnknownMode(text) from exc
        raise
    if not rows:
        raise NoRouteFound(f"No route from {start} to {goal}")
    row = rows[0]
    return {
        "route": _py(row["Route"]),
        "minutes": float(row["Minutes"]),
        "transfers": int(row["Transfers"]),
        "steps": [_step(s) for s in row["Steps"]],
    }


def find_route(mode: str, start: str, goal: str) -> dict:
    """Plan a route. Returns {"route", "minutes", "transfers", "steps"}.

    steps: list of
        {"type": "ride", "from", "to", "km", "min"}
        {"type": "transfer", "from", "to", "min"}
    """
    if mode not in MODES:
        raise UnknownMode(f"Unknown mode '{mode}'. Expected one of {MODES}")
    known = stations()
    for sid in (start, goal):
        if not isinstance(sid, str) or not _ID_RE.match(sid) or sid not in known:
            raise UnknownStation(f"Unknown station '{sid}'")
    if start == goal:
        raise SameStation("Origin and destination are the same station")
    return _run(_query_route, mode, start, goal)


if __name__ == "__main__":  # quick manual test: python prolog/bridge.py
    result = find_route("fastest", "bts_n24", "bts_n22")
    print(result["minutes"], result["transfers"], result["route"])