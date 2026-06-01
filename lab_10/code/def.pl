:- use_module(library(clpfd)).

solve_all(Nu, X, Depth, Frac, P, Q) :-
    NewX = X - 1,
    Depth #> 0,
    Frac = frac(1, 1 - InnerFrac),
    build_frac(Nu, NewX, 1, Depth, InnerFrac),
    transform(InnerFrac, P_inner, Q_inner),
    P = Q_inner,
    Q = Q_inner - P_inner.

build_frac(_, _, K, Depth, 0) :-
    K #> Depth.

build_frac(Nu, X, K, Depth, frac(A, B + NextFrac)) :-
    K #=< Depth,
    calc_term(Nu, X, K, A, B),
    K1 #= K + 1,
    build_frac(Nu, X, K1, Depth, NextFrac).

calc_term(Nu, X, 1, Nu * X, 1).

calc_term(Nu, X, K, (N + Nu) * X, 2) :-
    K #> 1,
    K mod 2 #= 0,
    N #= K // 2.

calc_term(Nu, X, K, (N - Nu) * X, B) :-
    K #> 1,
    K mod 2 #= 1,
    N #= K // 2,
    B #= 2 * N + 1.

transform(0, 0, 1).
transform(frac(A, B + Next), P_new, Q_new) :-
    transform(Next, P_sub, Q_sub),
    P_new = A * Q_sub,
    Q_new = B * Q_sub + P_sub.
