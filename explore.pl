  
:- dynamic(koord/2). /** koord(X, Y) **/
:- dynamic(action/0).

:- public(w/0).
:- public(a/0).
:- public(s/0).
:- public(d/0).


w :-
	\+ init(_),
	write('Game belum dimulai'), nl,
	!.

w :-
	isFighting(_),
	write('Kamu sedang bertarung'), nl,
	!.

w :- koord(X,Y),
	X_ is X-1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)),
    (isAroundBoss ->
    	bossTriggered
    ;
    	random(1, 100, Enemy),
    	(Enemy < 35 ->
    		enemyTriggered
    	)
    ), 
    !.

s :-
	\+ init(_),
	write('Game belum dimulai'), nl,
	!.

s :-
	isFighting(_),
	write('Kamu sedang bertarung'), nl,
	!.

s :- koord(X,Y),
	X_ is X+1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)),
    (isAroundBoss ->
    	bossTriggered
    ;
    	random(1, 100, Enemy),
    	(Enemy < 35 ->
    		enemyTriggered
    	)
    ), 
    !.

a :-
	\+ init(_),
	write('Game belum dimulai'), nl,
	!.

a :-
	isFighting(_),
	write('Kamu sedang bertarung'), nl,
	!.

a :- koord(X,Y),
	Y_ is Y-1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)),
    (isAroundBoss ->
    	bossTriggered
    ;
    	random(1, 100, Enemy),
    	(Enemy < 35 ->
    		enemyTriggered
    	)
    ),
    !.

d :-
	\+ init(_),
	write('Game belum dimulai'), nl,
	!.

d :-
	isFighting(_),
	write('Kamu sedang bertarung'), nl,
	!.

d :- koord(X,Y),
	Y_ is Y+1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)),
    (isAroundBoss ->
    	bossTriggered
    ;
    	random(1, 100, Enemy),
    	(Enemy < 35 ->
    		enemyTriggered
    	)
    ),
    !.

isValid(X,Y) :-
    X >= 0,
    Y >= 0,
    map_size(Xm,Ym),
    X < Xm,
    Y < Ym.

isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop - 1,
	YShop1 is YShop - 1,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop - 1,
	YShop1 is YShop,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop - 1,
	YShop1 is YShop + 1,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop,
	YShop1 is YShop - 1,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop,
	YShop1 is YShop + 1,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop + 1,
	YShop1 is YShop - 1,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop + 1,
	YShop1 is YShop,
	X == XShop1,
	Y == YShop1,
	!.
isAroundShop :-
	koord(X, Y),
	special_lokasi(XShop, YShop, 'S'),
	XShop1 is XShop + 1,
	YShop1 is YShop + 1,
	X == XShop1,
	Y == YShop1,
	!.				

isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss - 1,
	YBoss1 is YBoss - 1,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss - 1,
	YBoss1 is YBoss,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss - 1,
	YBoss1 is YBoss + 1,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss,
	YBoss1 is YBoss - 1,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss,
	YBoss1 is YBoss + 1,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss + 1,
	YBoss1 is YBoss - 1,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss + 1,
	YBoss1 is YBoss,
	X == XBoss1,
	Y == YBoss1,
	!.
isAroundBoss :-
	koord(X, Y),
	special_lokasi(XBoss, YBoss, 'D'),
	XBoss1 is XBoss + 1,
	YBoss1 is YBoss + 1,
	X == XBoss1,
	Y == YBoss1,
	!.

isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest - 1,
	YQuest1 is YQuest - 1,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest - 1,
	YQuest1 is YQuest,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest - 1,
	YQuest1 is YQuest + 1,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest,
	YQuest1 is YQuest - 1,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest,
	YQuest1 is YQuest + 1,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest + 1,
	YQuest1 is YQuest - 1,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest + 1,
	YQuest1 is YQuest,
	X == XQuest1,
	Y == YQuest1,
	!.
isAroundQuest :-
	koord(X, Y),
	special_lokasi(XQuest, YQuest, 'Q'),
	XQuest1 is XQuest + 1,
	YQuest1 is YQuest + 1,
	X == XQuest1,
	Y == YQuest1,
	!.	