:- use_module(library(clpfd)).
power_fraction(Nu, X, Depth, frac(1, 1 - Frac)) :-
    Depth #> 0,
    build_frac(Nu, X, 1, Depth, Frac).

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

eval_frac(0, 0).
eval_frac(frac(A_expr, B_expr + NextFrac), Result) :-
    eval_frac(NextFrac, NextVal),
    A is A_expr,
    B is B_expr,
    Result is A / (B + NextVal).

eval_frac(frac(A_expr, B_expr - NextFrac), Result) :-
    eval_frac(NextFrac, NextVal),
    A is A_expr,
    B is B_expr,
    Result is A / (B - NextVal).

calculate_power(Nu, X, Depth, Symbolic, Numeric) :-
    power_fraction(Nu, X, Depth, Symbolic),
    eval_frac(Symbolic, Numeric).
