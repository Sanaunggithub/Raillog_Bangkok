# Bangkok Raillog

## Prolog route planner

Load the planner and query a route using station identifiers from `network.pl`:

```prolog
?- [prolog/planner].
?- find_route(astar, bts_n8, mrt_bl22, Route, Minutes, Expanded).
?- route_steps(Route, Steps).
```

`find_route/6` supports `astar`, `ucs` (uniform-cost search), and `bfs`
(fewest rail/transfer hops). It returns the station-ID route, estimated travel
minutes, and the number of expanded nodes. `nodes_expanded/1` also exposes the
most recently completed search's count. `route_steps/2` describes consecutive
rail edges and transfers in a route.

Rail-edge time uses the network's train-speed and dwell parameters. Transfer
time uses the directed `transfer/3` facts plus `transfer_penalty/1`, whose
default value is zero minutes and can be changed in `prolog/planner.pl`. A*
uses haversine distance at 120 km/h as its time lower bound.

Run the planner tests from the repository root with:

```sh
swipl -g "run_tests" -t halt prolog/tests.pl
```