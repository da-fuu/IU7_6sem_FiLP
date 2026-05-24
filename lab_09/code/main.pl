find_grandparent(GP, GPGender, PGender, Child) :-
  parent(GP, Parent),
  gender(GP, GPGender),
  parent(Parent, Child),
  gender(Parent, PGender).

gender(petr, male).
gender(fedor, male).
gender(alexey, male).
gender(ivan, male).

gender(anna, female).
gender(olga, female).
gender(maria, female).

parent(petr, maria).
parent(anna, maria).
parent(fedor, alexey).
parent(olga, alexey).
parent(maria, ivan).
parent(alexey, ivan).

max2_no_cut(X, Y, X) :- X >= Y.
max2_no_cut(X, Y, Y) :- X < Y.
max2_cut(X, Y, X) :- X >= Y, !.
max2_cut(_, Y, Y).

max3_no_cut(X, Y, Z, X) :- X >= Y, X >= Z.
max3_no_cut(X, Y, Z, Y) :- Y > X, Y >= Z.
max3_no_cut(X, Y, Z, Z) :- Z > X, Z > Y.
max3_cut(X, Y, Z, X) :- X >= Y, X >= Z, !.
max3_cut(_, Y, Z, Y) :- Y >= Z, !.
max3_cut(_, _, Z, Z).
