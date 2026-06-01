process_lists([], [], _, []).

process_lists([H|T], L2, N, [H|ResultTail]) :-
    H > N, !,
    process_lists(T, L2, N, ResultTail).
process_lists([_|T], L2, N, ResultTail) :-
    !,
    process_lists(T, L2, N, ResultTail).

process_lists([], [H|T], N, [H|ResultTail]) :-
    H > N, !,
    process_lists([], T, N, ResultTail).
process_lists([], [_|T], N, ResultTail) :-
    !,
    process_lists([], T, N, ResultTail).
