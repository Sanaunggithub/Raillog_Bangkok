:- encoding(utf8).

:- consult('planner.pl').
:- use_module(library(plunit)).

comparison_pairs([
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
]).

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

test(unknown_mode_raises_error,
     [throws(error(domain_error(route_mode, quickest), _))]) :-
    plan(quickest, bts_cen, bts_e1, _, _, _).

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

test(astar_matches_ucs_and_expands_no_more_nodes_on_twenty_pairs) :-
    comparison_pairs(Pairs),
    forall(member(From-To, Pairs),
           ( find_route(astar, From, To, AStarRoute, AStarCost, AStarExpanded),
             find_route(ucs, From, To, UCSRoute, UcsCost, UcsExpanded),
             assertion(AStarRoute = [_|_]),
             assertion(UCSRoute = [_|_]),
             Difference is abs(AStarCost - UcsCost),
             assertion(Difference < 1.0e-8),
             assertion(AStarExpanded =< UcsExpanded)
           )).

test(hand_calculated_edge_cost) :-
    edge(bts_n24, bts_n23, DistanceKm),
    param(train_speed_kmh, Speed),
    param(dwell_min, Dwell),
    Expected is DistanceKm * 60 / Speed + Dwell,
    find_route(astar, bts_n24, bts_n23, [bts_n24, bts_n23], Cost, _),
    Difference is abs(Cost - Expected),
    assertion(Difference < 1.0e-6).

test(single_transfer_cost_includes_penalty) :-
    find_route(astar, bts_e4, mrt_bl22, [bts_e4, mrt_bl22], Cost, _),
    transfer(bts_e4, mrt_bl22, WalkMinutes),
    transfer_penalty(Penalty),
    Expected is WalkMinutes + Penalty,
    Difference is abs(Cost - Expected),
    assertion(Difference < 1.0e-6).

test(unreachable_goal, [fail]) :-
    setup_call_cleanup(
        ( dynamic(user:station/7),
          assertz(user:station(test_disconnected, 'Disconnected',
                               'Disconnected', test_operator, test_line, 0, 0))
        ),
        find_route(astar, bts_cen, test_disconnected, _, _, _),
        retractall(user:station(test_disconnected, _, _, _, _, _, _))
    ).

test(plan_modes_return_routes) :-
    forall(member(Mode, [fastest, fewest_transfers, fewest_stations]),
           ( plan(Mode, bts_n8, mrt_bl22, Route, Minutes, _),
             assertion(Route = [_|_]),
             assertion(Minutes > 0)
           )).

test(fewest_transfers_dominates_fastest_on_twenty_pairs) :-
    comparison_pairs(Pairs),
    forall(member(From-To, Pairs),
           ( plan(fastest, From, To, _, FastMinutes, FastTransfers),
             plan(fewest_transfers, From, To, _, FewestMinutes, FewestTransfers),
             assertion(FewestTransfers =< FastTransfers),
             assertion(FastMinutes =< FewestMinutes)
           )).

test(fewest_transfers_restores_previous_penalty) :-
    setup_call_cleanup(
        ( retractall(transfer_penalty(_)),
          assertz(transfer_penalty(7))
        ),
        ( plan(fewest_transfers, bts_n8, mrt_bl22, _, _, _),
          transfer_penalty(7)
        ),
        ( retractall(transfer_penalty(_)),
          assertz(transfer_penalty(3))
        )
    ).

:- end_tests(planner).
