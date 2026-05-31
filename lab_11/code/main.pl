list_length(List, Res) :-
    rec_len(List, 0, Res).

rec_len([], Len, Len) :- !.
rec_len([_|Rest], Len, Res) :-
    NewLen is Len + 1,
    rec_len(Rest, NewLen, Res).


list_sum(List, Res) :-
    rec_sum(List, 0, Res).

rec_sum([], Sum, Sum) :- !.
rec_sum([X|Rest], Sum, Res) :-
    NewSum is Sum + X,
    rec_sum(Rest, NewSum, Res).


list_odd_sum(List, Res) :-
    rec_odd_sum(List, 0, Res).

rec_odd_sum([], Sum, Sum) :- !.
rec_odd_sum([_], Sum, Sum) :- !.
rec_odd_sum([_, X | Rest], Sum, Res) :-
    NewSum is Sum + X,
    rec_odd_sum(Rest, NewSum, Res).


list_gt([], _, []) :- !.
list_gt([X | Rest], Num, [X | ResRest]) :-
    X > Num,
    !,
    list_gt(Rest, Num, ResRest).
list_gt([_ | Rest], Num, ResList) :-
    list_gt(Rest, Num, ResList).


list_del_one([], _, []) :- !.
list_del_one([Elem | Rest], Elem, Rest) :- !.
list_del_one([X | Rest], Elem, [X | ResRest]) :-
    list_del_one(Rest, Elem, ResRest).


list_del_many([], _, []) :- !.
list_del_many([Elem | Rest], Elem, ResList) :-
    !,
    list_del_many(Rest, Elem, ResList).
list_del_many([X | Rest], Elem, [X | ResRest]) :-
    list_del_many(Rest, Elem, ResRest).


list_join([], BList, BList) :- !.
list_join([X | ARest], BList, [X | ResRest]) :-
    list_join(ARest, BList, ResRest).
