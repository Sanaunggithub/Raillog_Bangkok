from __future__ import annotations

import html

import streamlit as st

import bridge

st.set_page_config(page_title="Bangkok Raillog", page_icon="🚆", layout="wide")

# Keys are the LineId values from network.pl.
LINE_STYLE = {
    "bts_sukhumvit":  ("BTS Sukhumvit",     "#76B947"),
    "bts_silom":      ("BTS Silom",         "#00674B"),
    "bts_gold":       ("BTS Gold",          "#C9A227"),
    "mrt_blue":       ("MRT Blue",          "#1E4D9B"),
    "mrt_purple":     ("MRT Purple",        "#7B2D8E"),
    "mrt_yellow":     ("MRT Yellow",        "#F2C500"),
    "mrt_pink":       ("MRT Pink",          "#F06FA0"),
    "mrt_pink_branch": ("MRT Pink (branch)", "#F7A1C2"),
    "arl":            ("Airport Rail Link", "#B5262E"),
    "srt_red_north":  ("SRT Dark Red",      "#9A1B1E"),
    "srt_red_west":   ("SRT Light Red",     "#E8603C"),
}
LINE_ORDER = list(LINE_STYLE)
TRANSFER_COLOR = "#808080"

MODE_LABELS = {
    "fastest": "Fastest",
    "fewest_transfers": "Fewest transfers",
    "fewest_stations": "Fewest stations",
}


def line_name(line_id: str) -> str:
    return LINE_STYLE.get(line_id, (line_id, "#808080"))[0]


def line_color(line_id: str) -> str:
    return LINE_STYLE.get(line_id, (line_id, "#808080"))[1]


def text_on(hex_color: str) -> str:
    """Readable text color (black/white) for a given background."""
    r, g, b = (int(hex_color[i:i + 2], 16) for i in (1, 3, 5))
    return "#000000" if (0.299 * r + 0.587 * g + 0.114 * b) > 150 else "#ffffff"


def rgb(hex_color: str) -> list[int]:
    return [int(hex_color[i:i + 2], 16) for i in (1, 3, 5)]


def badge(line_id: str) -> str:
    color = line_color(line_id)
    return (f'<span style="background:{color};color:{text_on(color)};'
            f'padding:2px 10px;border-radius:12px;font-size:0.8em;'
            f'font-weight:600;white-space:nowrap">{html.escape(line_name(line_id))}</span>')


# data
try:
    STATIONS = bridge.stations()
except Exception as exc:  # engine/SWI-Prolog problems
    st.error(f"Could not load the Prolog planner: {exc}")
    st.info("Check that SWI-Prolog is installed (on Windows you may need to "
            "set SWI_HOME_DIR or add SWI-Prolog's bin folder to PATH) and "
            "that pyswip is installed.")
    st.stop()

STATION_IDS = sorted(
    STATIONS,
    key=lambda sid: (LINE_ORDER.index(STATIONS[sid]["line"])
                     if STATIONS[sid]["line"] in LINE_ORDER else 99, sid),
)


def station_label(sid: str) -> str:
    s = STATIONS[sid]
    return f'{s["name_en"]} ({s["name_th"]}) – {line_name(s["line"])}'


def short_name(sid: str) -> str:
    s = STATIONS[sid]
    return f'{s["name_en"]} ({s["name_th"]})'


# step grouping
def build_rows(steps: list[dict]) -> list[dict]:
    """Merge consecutive rides on the same line into one row."""
    rows: list[dict] = []
    cur = None
    for step in steps:
        if step["type"] == "ride":
            line = STATIONS[step["from"]]["line"]
            if cur and cur["line"] == line:
                cur["to"] = step["to"]
                cur["km"] += step["km"]
                cur["min"] += step["min"]
                cur["stops"].append(step["to"])
            else:
                if cur:
                    rows.append(cur)
                cur = {"type": "ride", "line": line, "from": step["from"],
                       "to": step["to"], "km": step["km"], "min": step["min"],
                       "stops": [step["from"], step["to"]]}
        else:
            if cur:
                rows.append(cur)
                cur = None
            rows.append(step)
    if cur:
        rows.append(cur)
    return rows


def render_row(row: dict, show_all: bool) -> None:
    if row["type"] == "ride":
        color = line_color(row["line"])
        n = len(row["stops"]) - 1
        text = (f'Ride <b>{html.escape(short_name(row["from"]))}</b> → '
                f'<b>{html.escape(short_name(row["to"]))}</b>')
        meta = f'{n} stop{"s" if n != 1 else ""} · {row["km"]:.1f} km'
        extra = ""
        if show_all and n > 1:
            names = " → ".join(html.escape(STATIONS[s]["name_en"])
                               for s in row["stops"])
            extra = f'<div style="font-size:0.8em;opacity:0.7;margin-top:4px">{names}</div>'
        st.markdown(
            f'<div style="border-left:6px solid {color};padding:6px 12px;'
            f'margin:6px 0;background:rgba(128,128,128,0.08);border-radius:4px">'
            f'<div style="display:flex;justify-content:space-between;gap:12px">'
            f'<div>{badge(row["line"])}&nbsp; {text}'
            f'<div style="font-size:0.85em;opacity:0.75">{meta}</div></div>'
            f'<div style="white-space:nowrap;font-weight:600">{row["min"]:.1f} min</div>'
            f'</div>{extra}</div>',
            unsafe_allow_html=True)
    else:
        src, dst = STATIONS[row["from"]], STATIONS[row["to"]]
        text = (f'Transfer at <b>{html.escape(short_name(row["from"]))}</b> '
                f'to {badge(dst["line"])}')
        if src["name_en"] != dst["name_en"]:
            text += f' (walk to <b>{html.escape(short_name(row["to"]))}</b>)'
        st.markdown(
            f'<div style="border-left:6px dashed {TRANSFER_COLOR};padding:6px 12px;'
            f'margin:6px 0;background:rgba(128,128,128,0.08);border-radius:4px">'
            f'<div style="display:flex;justify-content:space-between;gap:12px">'
            f'<div>{text}</div>'
            f'<div style="white-space:nowrap;font-weight:600">{row["min"]:.1f} min</div>'
            f'</div></div>',
            unsafe_allow_html=True)


# map 
def render_map(result: dict) -> None:
    try:
        import pydeck as pdk
    except ImportError:
        st.info("Install pydeck to see the route map (pip install pydeck).")
        return

    route, steps = result["route"], result["steps"]
    segments = []
    for step in steps:
        a, b = STATIONS[step["from"]], STATIONS[step["to"]]
        if step["type"] == "ride":
            color, name = line_color(a["line"]), line_name(a["line"])
        else:
            color, name = TRANSFER_COLOR, "Transfer"
        segments.append({"path": [[a["lng"], a["lat"]], [b["lng"], b["lat"]]],
                         "color": rgb(color) + [255], "name": name})

    points = [{"position": [STATIONS[s]["lng"], STATIONS[s]["lat"]],
               "name": short_name(s),
               "color": rgb(line_color(STATIONS[s]["line"])) + [255]}
              for s in route]
    ends = [points[0], points[-1]]
    coords = [p["position"] for p in points]

    layers = [
        pdk.Layer("PathLayer", segments, get_path="path", get_color="color",
                  width_min_pixels=5, pickable=True),
        pdk.Layer("ScatterplotLayer", points, get_position="position",
                  get_fill_color="color", get_line_color=[255, 255, 255, 255],
                  stroked=True, line_width_min_pixels=1, radius_min_pixels=4,
                  get_radius=60, pickable=True),
        pdk.Layer("ScatterplotLayer", ends, get_position="position",
                  get_fill_color=[255, 255, 255, 255],
                  get_line_color=[0, 0, 0, 255], stroked=True,
                  line_width_min_pixels=3, radius_min_pixels=9, get_radius=100,
                  pickable=True),
    ]
    try:
        view = pdk.data_utils.compute_view(coords)
        view.pitch = 0
    except Exception:
        view = pdk.ViewState(latitude=sum(c[1] for c in coords) / len(coords),
                             longitude=sum(c[0] for c in coords) / len(coords),
                             zoom=11)
    st.pydeck_chart(pdk.Deck(
        layers=layers, initial_view_state=view, tooltip={"text": "{name}"},
        map_style="https://basemaps.cartocdn.com/gl/positron-gl-style/style.json"))


# UI 
st.title("🚆 Bangkok Raillog")
st.caption("Route planner for BTS, MRT, Airport Rail Link and SRT Red Lines")

col_from, col_to = st.columns(2)
with col_from:
    origin = st.selectbox("Origin", STATION_IDS, index=None,
                          format_func=station_label,
                          placeholder="Type to search a station…")
with col_to:
    destination = st.selectbox("Destination", STATION_IDS, index=None,
                               format_func=station_label,
                               placeholder="Type to search a station…")

mode = st.radio("Route preference", list(MODE_LABELS), horizontal=True,
                format_func=MODE_LABELS.get)
show_all = st.checkbox("Show every station along each ride", value=False)

if st.button("Search", type="primary"):
    if origin is None or destination is None:
        st.session_state["outcome"] = ("warning",
                                       "Please choose both an origin and a destination.")
    else:
        try:
            result = bridge.find_route(mode, origin, destination)
            st.session_state["outcome"] = ("ok", result)
        except bridge.SameStation:
            st.session_state["outcome"] = (
                "warning", "Origin and destination are the same station. "
                           "Please pick two different stations.")
        except bridge.NoRouteFound:
            st.session_state["outcome"] = (
                "warning", f"No route found between {short_name(origin)} and "
                           f"{short_name(destination)}.")
        except bridge.UnknownStation as exc:
            st.session_state["outcome"] = ("error", f"Unknown station: {exc}")
        except bridge.UnknownMode as exc:
            st.session_state["outcome"] = ("error", f"Unknown route mode: {exc}")
        except Exception as exc:  # unexpected Prolog/pyswip failure
            st.session_state["outcome"] = ("error", f"Planner error: {exc}")

outcome = st.session_state.get("outcome")
if outcome:
    kind, payload = outcome
    if kind == "warning":
        st.warning(payload)
    elif kind == "error":
        st.error(payload)
    else:
        result = payload
        rides = sum(1 for s in result["steps"] if s["type"] == "ride")
        m1, m2, m3 = st.columns(3)
        m1.metric("Total time", f'{result["minutes"]:.1f} min')
        m2.metric("Transfers", result["transfers"])
        m3.metric("Stops", rides)

        st.subheader("Step by step")
        first, last = result["route"][0], result["route"][-1]
        st.markdown(f"**Start:** {html.escape(short_name(first))} "
                    f"{badge(STATIONS[first]['line'])}", unsafe_allow_html=True)
        for row in build_rows(result["steps"]):
            render_row(row, show_all)
        st.markdown(f"**Arrive:** {html.escape(short_name(last))} "
                    f"{badge(STATIONS[last]['line'])}", unsafe_allow_html=True)
        st.caption("Transfer times include the planner's transfer penalty.")

        st.subheader("Map")
        render_map(result)
