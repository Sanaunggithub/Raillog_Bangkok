:- encoding(utf8).

:- consult('planner.pl').
:- use_module(library(plunit)).

:- begin_tests(planner).

test(same_station_route) :-
    find_route(astar, bts_cen, bts_cen, [bts_cen], 0, 0).

test(route_steps_identify_rail_and_transfer_steps) :-
    route_steps([bts_e3, bts_e4, mrt_bl22], Steps),
    Steps = [ride(bts_e3, bts_e4, _, _),
             transfer(bts_e4, mrt_bl22, _)].

test(breadth_first_route_is_valid) :-
    find_route(bfs, bts_n8, mrt_bl22, Route, Cost, Expanded),
    Route = [bts_n8|_],
    last(Route, mrt_bl22),
    Cost > 0,
    Expanded > 0.

test(nodes_expanded_counter_is_recorded) :-
    find_route(ucs, bts_cen, bts_e1, _Route, _Cost, Expanded),
    nodes_expanded(Expanded).

test(unknown_station_raises_error,
     [throws(error(existence_error(station, unknown_station), _))]) :-
    find_route(astar, unknown_station, bts_cen, _, _, _).

test(unknown_algorithm_raises_error,
     [throws(error(domain_error(route_algorithm, dijkstra), _))]) :-
    find_route(dijkstra, bts_cen, bts_e1, _, _, _).

test(haversine_heuristic_is_admissible_on_every_edge) :-
    forall(edge(From, To, DistanceKm),
           ( planner:heuristic(astar, From, To, H),
             param(train_speed_kmh, Speed),
             param(dwell_min, Dwell),
             EdgeMinutes is DistanceKm * 60 / Speed + Dwell,
             assertion(H =< EdgeMinutes)
           )),
    forall(transfer(From, To, TransferMinutes),
           ( planner:heuristic(astar, From, To, H),
             transfer_penalty(Penalty),
             EdgeMinutes is TransferMinutes + Penalty,
             assertion(H =< EdgeMinutes)
           )).

test(astar_matches_ucs_on_twenty_pairs) :-
    Pairs = [
        bts_n24-bts_e23,
        bts_n24-bts_s12,
        bts_n8-mrt_bl22,
        bts_s12-mrt_bl01,
        bts_n17-mrt_pk30,
        bts_e23-mrt_pk01,
        mrt_bl01-mrt_pp11,
        mrt_pp11-mrt_pk30,
        mrt_yl01-bts_e23,
        arl_a8-arl_a4,
        srt_rn00-bts_e23,
        srt_rw01-mrt_bl01,
        bts_g1-mrt_bl01,
        mrt_pk01-mrt_bl34,
        mrt_yl11-mrt_pp11,
        mrt_bl13-mrt_yl23,
        bts_s2-mrt_pp16,
        mrt_pk10-bts_n24,
        bts_e4-mrt_yl11,
        mrt_bl34-srt_rw01
    ],
    forall(member(From-To, Pairs),
           ( find_route(astar, From, To, AStarRoute, AStarCost, _),
             find_route(ucs, From, To, UCSRoute, UcsCost, _),
             assertion(AStarRoute = [_|_]),
             assertion(UCSRoute = [_|_]),
             Difference is abs(AStarCost - UcsCost),
             assertion(Difference < 1.0e-8)
           )).

:- end_tests(planner).
