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


solve_optimized(Nu, X, Depth, Frac, P_raw, Q_raw, P_horner, Q_horner, P_opt, Q_opt) :-
    solve_all(Nu, X, Depth, Frac, P_raw, Q_raw),
    eval_ast(P_raw, P_horner),
    eval_ast(Q_raw, Q_horner),
    to_standard(P_horner, P_opt),
    to_standard(Q_horner, Q_opt).

is_scalar(N) :- number(N), !.

eval_ast(x, 0.0 + x * 1.0) :- !.
eval_ast(N, N) :- is_scalar(N), !.
eval_ast(A + B, R) :- eval_ast(A, EA), eval_ast(B, EB), add_poly(EA, EB, R).
eval_ast(A - B, R) :- eval_ast(A, EA), eval_ast(B, EB), sub_poly(EA, EB, R).
eval_ast(A * B, R) :- eval_ast(A, EA), eval_ast(B, EB), mult_poly(EA, EB, R).

add_poly(N1, N2, R) :- is_scalar(N1), is_scalar(N2), !, R is N1 + N2.
add_poly(N, C + x * P, R + x * P) :- is_scalar(N), !, R is N + C.
add_poly(C + x * P, N, R + x * P) :- is_scalar(N), !, R is C + N.
add_poly(C1 + x * P1, C2 + x * P2, C3 + x * P3) :- C3 is C1 + C2, add_poly(P1, P2, P3).

neg_poly(N, R) :- is_scalar(N), !, R is -N.
neg_poly(C + x * P, NC + x * NP) :- NC is -C, neg_poly(P, NP).

sub_poly(P1, P2, R) :- neg_poly(P2, NP2), add_poly(P1, NP2, R).

mult_scalar(S, N, R) :- is_scalar(N), !, R is S * N.
mult_scalar(S, C + x * P, RC + x * RP) :- RC is S * C, mult_scalar(S, P, RP).

mult_poly(N, P, R) :- is_scalar(N), !, mult_scalar(N, P, R).
mult_poly(P, N, R) :- is_scalar(N), !, mult_scalar(N, P, R).
mult_poly(C1 + x * P1, P2, R) :-
    mult_scalar(C1, P2, Part1),
    mult_poly(P1, P2, P1P2),
    mult_x(P1P2, Part2),
    add_poly(Part1, Part2, R).

mult_x(N, 0.0 + x * N) :- is_scalar(N), !.
mult_x(C + x * P, 0.0 + x * (C + x * P)).

to_standard(Horner, Std) :-
    to_std_acc(Horner, 0, empty, Result),
    (Result = empty -> Std = 0.0 ; Std = Result).

to_std_acc(0.0, _, Acc, Acc) :- !.
to_std_acc(0, _, Acc, Acc) :- !.
to_std_acc(N, D, Acc, FinalAcc) :- is_scalar(N), !,
    make_term(N, D, Term),
    add_term(Acc, Term, FinalAcc).

to_std_acc(0.0 + x * P, D, Acc, Res) :- !,
    D1 is D + 1,
    to_std_acc(P, D1, Acc, Res).
to_std_acc(0 + x * P, D, Acc, Res) :- !,
    D1 is D + 1,
    to_std_acc(P, D1, Acc, Res).

to_std_acc(C + x * P, D, Acc, Res) :-
    make_term(C, D, Term),
    add_term(Acc, Term, NewAcc),
    D1 is D + 1,
    to_std_acc(P, D1, NewAcc, Res).

make_term(C, 0, C) :- !.
make_term(C, 1, C*x) :- !.
make_term(C, D, C*x^D).

add_term(empty, Term, Term) :- !.
add_term(Acc, Term, Acc + Term).
