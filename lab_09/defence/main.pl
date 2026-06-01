gender(petr, male).
gender(fedor, male).
gender(alexey, male).
gender(ivan, male).

gender(anna, female).
gender(olga, female).
gender(maria, female).
gender(elena, female).

parent(petr, maria).
parent(anna, maria).
parent(fedor, alexey).
parent(olga, alexey).
parent(maria, ivan).
parent(alexey, ivan).
parent(fedor, elena).
parent(olga, elena).

sibling(A, B) :-
    parent(P, A),
    parent(P, B),
    A \= B,
    !.

married(Wife, Husband) :-
  parent(Wife, Child),
  parent(Husband, Child),
  Husband \= Wife.

zolovka(Zolovka, Wife) :-
    gender(Wife, female),
    married(Wife, Husband),
    gender(Husband, male),
    sibling(Zolovka, Husband),
    gender(Zolovka, female).

tescha(Tescha, Husband) :-
    gender(Husband, male),
    married(Wife, Husband),
    gender(Wife, female),
    parent(Tescha, Wife),
    gender(Tescha, female).

zyat(Zyat, Parent) :-
    parent(Parent, Daughter),
    gender(Daughter, female),
    married(Daughter, Zyat),
    gender(Zyat, male).
