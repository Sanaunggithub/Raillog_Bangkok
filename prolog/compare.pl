:- encoding(utf8).

:- ensure_loaded('planner.pl').
:- use_module(library(filesex)).
:- use_module(library(lists)).

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

comparison_repetitions(20).

compare :-
    collect_comparison_rows(Rows),
    print_comparison_table(Rows),
    print_comparison_summary(Rows).

compare_csv(File) :-
    collect_comparison_rows(Rows),
    file_directory_name(File, Directory),
    (   exists_directory(Directory)
    ->  true
    ;   make_directory_path(Directory)
    ),
    setup_call_cleanup(
        open(File, write, Stream, [encoding(utf8)]),
        write_comparison_csv(Stream, Rows),
        close(Stream)
    ),
    format('Wrote comparison CSV to ~w~n', [File]).

collect_comparison_rows(Rows) :-
    comparison_pairs(Pairs),
    maplist(compare_pair, Pairs, Rows).

compare_pair(From-To,
             row(From, To, AStarCost, UcsCost, BfsCost,
                 AStarExpanded, UcsExpanded, BfsExpanded,
                 AStarMs, UcsMs, BfsMs)) :-
    benchmark(astar, From, To, AStarCost, AStarExpanded, AStarMs),
    benchmark(ucs, From, To, UcsCost, UcsExpanded, UcsMs),
    benchmark(bfs, From, To, BfsCost, BfsExpanded, BfsMs).

benchmark(Algorithm, Start, Goal, Cost, Expanded, AverageMs) :-
    comparison_repetitions(Repetitions),
    statistics(cputime, Started),
    repeat_searches(Repetitions, Algorithm, Start, Goal,
                    Cost, Expanded),
    statistics(cputime, Finished),
    AverageMs is (Finished - Started) * 1000 / Repetitions.

repeat_searches(0, _Algorithm, _Start, _Goal, _Cost, _Expanded).
repeat_searches(Count, Algorithm, Start, Goal, Cost, Expanded) :-
    Count > 0,
    find_route(Algorithm, Start, Goal, _Route, Cost0, Expanded0),
    Remaining is Count - 1,
    repeat_searches(Remaining, Algorithm, Start, Goal, Cost0, Expanded0),
    Cost = Cost0,
    Expanded = Expanded0.

print_comparison_table(Rows) :-
    format('~w~n',
           ['pair | A* cost | UCS cost | BFS cost | A* expanded | UCS expanded | BFS expanded | A* ms | UCS ms | BFS ms']),
    format('~w~n',
           ['-----|---------|----------|----------|-------------|--------------|--------------|-------|--------|-------']),
    maplist(print_comparison_row, Rows).

print_comparison_row(row(From, To, AStarCost, UcsCost, BfsCost,
                         AStarExpanded, UcsExpanded, BfsExpanded,
                         AStarMs, UcsMs, BfsMs)) :-
    format('~w->~w | ~2f | ~2f | ~2f | ~d | ~d | ~d | ~3f | ~3f | ~3f~n',
           [From, To, AStarCost, UcsCost, BfsCost,
            AStarExpanded, UcsExpanded, BfsExpanded,
            AStarMs, UcsMs, BfsMs]).

print_comparison_summary(Rows) :-
    row_sums(Rows, Totals),
    length(Rows, PairCount),
    Totals = totals(AStarCost, UcsCost, BfsCost,
                    AStarExpanded, UcsExpanded, BfsExpanded,
                    AStarMs, UcsMs, BfsMs),
    AStarAverageExpanded is AStarExpanded / PairCount,
    UcsAverageExpanded is UcsExpanded / PairCount,
    BfsAverageExpanded is BfsExpanded / PairCount,
    AStarAverageMs is AStarMs / PairCount,
    UcsAverageMs is UcsMs / PairCount,
    BfsAverageMs is BfsMs / PairCount,
    AStarSavedPercent is (UcsExpanded - AStarExpanded) * 100 / UcsExpanded,
    format('~nTotals (over ~d pairs):~n', [PairCount]),
    format('  Cost (minutes): A* ~2f, UCS ~2f, BFS ~2f~n',
           [AStarCost, UcsCost, BfsCost]),
    format('  Expanded nodes: A* ~d, UCS ~d, BFS ~d~n',
           [AStarExpanded, UcsExpanded, BfsExpanded]),
    format('  Average expanded nodes: A* ~2f, UCS ~2f, BFS ~2f~n',
           [AStarAverageExpanded, UcsAverageExpanded, BfsAverageExpanded]),
    format('  Average runtime (ms/search): A* ~3f, UCS ~3f, BFS ~3f~n',
           [AStarAverageMs, UcsAverageMs, BfsAverageMs]),
    format('  Runtime total (ms): A* ~3f, UCS ~3f, BFS ~3f~n',
           [AStarMs, UcsMs, BfsMs]),
    format('  A* nodes saved vs UCS: ~2f%~n', [AStarSavedPercent]).

row_sums(Rows, totals(AStarCost, UcsCost, BfsCost,
                      AStarExpanded, UcsExpanded, BfsExpanded,
                      AStarMs, UcsMs, BfsMs)) :-
    findall(Cost, member(row(_, _, Cost, _, _, _, _, _, _, _, _), Rows),
            AStarCosts),
    findall(Cost, member(row(_, _, _, Cost, _, _, _, _, _, _, _), Rows),
            UcsCosts),
    findall(Cost, member(row(_, _, _, _, Cost, _, _, _, _, _, _), Rows),
            BfsCosts),
    findall(Count, member(row(_, _, _, _, _, Count, _, _, _, _, _), Rows),
            AStarCounts),
    findall(Count, member(row(_, _, _, _, _, _, Count, _, _, _, _), Rows),
            UcsCounts),
    findall(Count, member(row(_, _, _, _, _, _, _, Count, _, _, _), Rows),
            BfsCounts),
    findall(Ms, member(row(_, _, _, _, _, _, _, _, Ms, _, _), Rows),
            AStarTimes),
    findall(Ms, member(row(_, _, _, _, _, _, _, _, _, Ms, _), Rows),
            UcsTimes),
    findall(Ms, member(row(_, _, _, _, _, _, _, _, _, _, Ms), Rows),
            BfsTimes),
    sum_list(AStarCosts, AStarCost),
    sum_list(UcsCosts, UcsCost),
    sum_list(BfsCosts, BfsCost),
    sum_list(AStarCounts, AStarExpanded),
    sum_list(UcsCounts, UcsExpanded),
    sum_list(BfsCounts, BfsExpanded),
    sum_list(AStarTimes, AStarMs),
    sum_list(UcsTimes, UcsMs),
    sum_list(BfsTimes, BfsMs).

write_comparison_csv(Stream, Rows) :-
    format(Stream, 'pair,A* cost,UCS cost,BFS cost,A* expanded,UCS expanded,BFS expanded,A* ms,UCS ms,BFS ms~n', []),
    maplist(write_comparison_csv_row(Stream), Rows).

write_comparison_csv_row(Stream,
                         row(From, To, AStarCost, UcsCost, BfsCost,
                             AStarExpanded, UcsExpanded, BfsExpanded,
                             AStarMs, UcsMs, BfsMs)) :-
    format(Stream, '~w->~w,~6f,~6f,~6f,~d,~d,~d,~6f,~6f,~6f~n',
           [From, To, AStarCost, UcsCost, BfsCost,
            AStarExpanded, UcsExpanded, BfsExpanded,
            AStarMs, UcsMs, BfsMs]).
