factorial_tail(0, Acc, Acc) :- !.
factorial_tail(N, Acc, Result) :-
    N > 0,
    NewAcc is Acc * N,
    NewN is N - 1,
    factorial_tail(NewN, NewAcc, Result).

factorial(N, Result) :- factorial_tail(N, 1, Result).


fib_tail(0, Acc1, _, Acc1) :- !.
fib_tail(N, Acc1, Acc2, Result) :-
    N > 0,
    NewAcc2 is Acc1 + Acc2,
    NewN is N - 1,
    fib_tail(NewN, Acc2, NewAcc2, Result).

fibonacci(N, Result) :- fib_tail(N, 0, 1, Result).
