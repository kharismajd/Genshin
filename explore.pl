:- dynamic(koord/2). /** koord(X, Y) **/
:- dynamic(action/0).

:- public(w/0).
:- public(a/0).
:- public(s/0).
:- public(d/0).

w :- koord(X,Y),
    Y_ is Y-1,
    \+ special_lokasi(X,Y_,'#'),
    isValid(X,Y_), !,
    retractall(koord(_,_)),
    asserta(koord(X,Y_)),
    (action; true).
	
s :- koord(X,Y),
    Y_ is Y+1,
    \+ special_lokasi(X,Y_,'#'),
    isValid(X,Y_), !,
    retractall(koord(_,_)),
    asserta(koord(X,Y_)),
    (action; true).

a :- koord(X,Y),
    X_ is X-1,
    \+ special_lokasi(X_,Y,'#'),
    isValid(X_,Y), !,
    retractall(koord(_,_)),
    asserta(koord(X_,Y)),
    (action; true).

d :- koord(X,Y),
	X_ is X+1,
    \+ special_lokasi(X_,Y,'#'),
    isValid(X_,Y), !,
    retractall(koord(_,_)),
    asserta(koord(X_,Y)),
    (action; true).

isValid(_,_) :-
    \+ init(_), !,
    write('Game belum dimulai'), nl,
    fail.

isValid(_,_) :-
    isFighting(_), !,
    write('Kamu sedang bertarung'), nl,
    fail.

isValid(X,Y) :-
    X > 0, Y > 0,
    map_size(Xm,Ym),
    X =< Xm, Y =< Ym.

isAroundShop :-
    koord(X, Y),
    special_lokasi(XShop, YShop, 'S'),
    X == XShop,
    Y == YShop,
    !.

isAroundBoss :-
    koord(X, Y),
    special_lokasi(XBoss, YBoss, 'D'),
    X == XBoss,
    Y == YBoss,
    !.

isAroundQuest :-
    koord(X, Y),
    special_lokasi(XQuest, YQuest, 'Q'),
    X == XQuest,
    Y == YQuest,
    !.

action :- isAroundBoss, !, bossTriggered.
action :- random(1, 100, Enemy), Enemy < 35, enemyTriggered.
