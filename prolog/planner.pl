:- encoding(utf8).

:- ensure_loaded('network.pl').

:- use_module(library(assoc)).
:- use_module(library(heaps)).
:- use_module(library(lists)).

:- dynamic transfer_penalty/1.
:- dynamic nodes_expanded/1.

transfer_penalty(0).

heuristic_speed_kmh(120).

find_route(Algorithm, Start, Goal, Route, Cost, Expanded) :-
    ensure_station(Start),
    ensure_station(Goal),
    run_search(Algorithm, Start, Goal, Route, Cost, Expanded),
    retractall(nodes_expanded(_)),
    assertz(nodes_expanded(Expanded)).

astar(Start, Goal, Route, Cost, Expanded) :-
    find_route(astar, Start, Goal, Route, Cost, Expanded).

ucs(Start, Goal, Route, Cost, Expanded) :-
    find_route(ucs, Start, Goal, Route, Cost, Expanded).

bfs(Start, Goal, Route, Cost, Expanded) :-
    find_route(bfs, Start, Goal, Route, Cost, Expanded).

run_search(Algorithm, Start, Goal, Route, Cost, Expanded) :-
    (   memberchk(Algorithm, [astar, a_star])
    ->  best_first_search(astar, Start, Goal, Route, Cost, Expanded)
    ;   Algorithm == ucs
    ->  best_first_search(ucs, Start, Goal, Route, Cost, Expanded)
    ;   Algorithm == bfs
    ->  breadth_first_search(Start, Goal, Route, Cost, Expanded)
    ;   throw(error(domain_error(route_algorithm, Algorithm),
                    context(find_route/6, 'Expected astar, ucs, or bfs')))
    ).

ensure_station(Station) :-
    (   station(Station, _, _, _, _, _, _)
    ->  true
    ;   throw(error(existence_error(station, Station),
                    context(find_route/6, 'Unknown station identifier')))
    ).

best_first_search(Algorithm, Start, Goal, Route, Cost, Expanded) :-
    empty_heap(EmptyHeap),
    empty_assoc(EmptyBest),
    put_assoc(Start, EmptyBest, 0, Best),
    heuristic(Algorithm, Start, Goal, H),
    add_to_heap(EmptyHeap, H-0-0, state(Start, 0, [Start]), Heap),
    search_heap(Heap, Best, 1, Algorithm, Goal, 0, Route, Cost, Expanded).

search_heap(Heap, Best, Serial, Algorithm, Goal, Expanded0,
            Route, Cost, Expanded) :-
    get_from_heap(Heap, _Priority, state(Node, G, Path), Heap1),
    (   get_assoc(Node, Best, BestG),
        G =:= BestG
    ->  (   Node == Goal
        ->  reverse(Path, Route),
            Cost = G,
            Expanded = Expanded0
        ;   Expanded1 is Expanded0 + 1,
            findall(Next-StepCost, neighbor(Node, Next, StepCost), Neighbors),
            relax_neighbors(Neighbors, G, Path, Goal, Algorithm,
                            Heap1, Best, Serial, Heap2, Best2, Serial2),
            search_heap(Heap2, Best2, Serial2, Algorithm, Goal, Expanded1,
                        Route, Cost, Expanded)
        )
    ;   search_heap(Heap1, Best, Serial, Algorithm, Goal, Expanded0,
                    Route, Cost, Expanded)
    ).

relax_neighbors([], _G, _Path, _Goal, _Algorithm,
                Heap, Best, Serial, Heap, Best, Serial).
relax_neighbors([Next-StepCost|Rest], G, Path, Goal, Algorithm,
                Heap0, Best0, Serial0, Heap, Best, Serial) :-
    NewG is G + StepCost,
    (   get_assoc(Next, Best0, OldG),
        NewG >= OldG
    ->  Heap1 = Heap0,
        Best1 = Best0,
        Serial1 = Serial0
    ;   put_assoc(Next, Best0, NewG, Best1),
        heuristic(Algorithm, Next, Goal, H),
        Priority is NewG + H,
        add_to_heap(Heap0, Priority-NewG-Serial0,
                    state(Next, NewG, [Next|Path]), Heap1),
        Serial1 is Serial0 + 1
    ),
    relax_neighbors(Rest, G, Path, Goal, Algorithm,
                    Heap1, Best1, Serial1, Heap, Best, Serial).

heuristic(ucs, _Node, _Goal, 0) :-
    !.
heuristic(astar, Node, Goal, Minutes) :-
    haversine_km(Node, Goal, Distance),
    heuristic_speed_kmh(Speed),
    Minutes is Distance * 60 / Speed.

breadth_first_search(Start, Goal, Route, Cost, Expanded) :-
    breadth_first_queue([state(Start, [Start], 0)], [Start], Goal,
                        0, Route, Cost, Expanded).

breadth_first_queue([state(Node, Path, Cost0)|_], _Seen, Goal, Expanded,
                    Route, Cost, Expanded) :-
    Node == Goal,
    !,
    reverse(Path, Route),
    Cost = Cost0.
breadth_first_queue([state(Node, Path, Cost0)|Queue], Seen, Goal, Expanded0,
                    Route, Cost, Expanded) :-
    Expanded1 is Expanded0 + 1,
    findall(Next-StepCost,
            ( neighbor(Node, Next, StepCost),
              \+ memberchk(Next, Seen)
            ),
            Neighbors),
    enqueue_neighbors(Neighbors, Path, Cost0, Queue, Queue1,
                      Seen, Seen1),
    breadth_first_queue(Queue1, Seen1, Goal, Expanded1,
                        Route, Cost, Expanded).

enqueue_neighbors([], _Path, _Cost, Queue, Queue, Seen, Seen).
enqueue_neighbors([Next-StepCost|Rest], Path, Cost0, Queue0, Queue,
                  Seen0, Seen) :-
    Cost1 is Cost0 + StepCost,
    append(Queue0, [state(Next, [Next|Path], Cost1)], Queue1),
    enqueue_neighbors(Rest, Path, Cost0, Queue1, Queue,
                      [Next|Seen0], Seen).

neighbor(From, To, Minutes) :-
    edge(From, To, DistanceKm),
    param(train_speed_kmh, Speed),
    param(dwell_min, Dwell),
    Minutes is DistanceKm * 60 / Speed + Dwell.
neighbor(From, To, Minutes) :-
    transfer(From, To, TransferMinutes),
    transfer_penalty(Penalty),
    Minutes is TransferMinutes + Penalty.

haversine_km(From, To, DistanceKm) :-
    station(From, _, _, _, _, Lat1, Lon1),
    station(To, _, _, _, _, Lat2, Lon2),
    DegreesToRadians is pi / 180,
    Phi1 is Lat1 * DegreesToRadians,
    Phi2 is Lat2 * DegreesToRadians,
    DeltaPhi is (Lat2 - Lat1) * DegreesToRadians,
    DeltaLambda is (Lon2 - Lon1) * DegreesToRadians,
    A is sin(DeltaPhi / 2) ** 2
       + cos(Phi1) * cos(Phi2) * sin(DeltaLambda / 2) ** 2,
    CentralAngle is 2 * atan2(sqrt(A), sqrt(1 - A)),
    DistanceKm is 6371 * CentralAngle.

route_steps([_], []) :-
    !.
route_steps([From, To|Rest], [Step|Steps]) :-
    !,
    route_step(From, To, Step),
    route_steps([To|Rest], Steps).

route_step(From, To, ride(From, To, DistanceKm, Minutes)) :-
    edge(From, To, DistanceKm),
    neighbor(From, To, Minutes),
    !.
route_step(From, To, transfer(From, To, Minutes)) :-
    transfer(From, To, TransferMinutes),
    transfer_penalty(Penalty),
    Minutes is TransferMinutes + Penalty,
    !.
