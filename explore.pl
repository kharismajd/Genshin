  
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
	(
		X == 1,
		Y == 1
	)
	;
	(
		X == 1,
		Y == 2
	)
	;
	(
		X == 1,
		Y == 3
	)
	;
	(
		X == 2,
		Y == 1
	)
	;
	(
		X == 2,
		Y == 3
	)
	;
	(
		X == 3,
		Y == 1
	)
	;
	(
		X == 3,
		Y == 2
	)
	;
	(
		X == 3,
		Y == 3
	).

isAroundBoss :-
	koord(X, Y),
	(
		X == 9,
		Y == 10
	)
	;
	(
		X == 9,
		Y == 9
	)
	;
	(
		X == 10,
		Y == 9
	).

isAroundQuest :-
	koord(X, Y),
	(
		X == 4,
		Y == 3
	)
	;
	(
		X == 4,
		Y == 5
	)
	;
	(
		X == 4,
		Y == 6
	)
	;
	(
		X == 5,
		Y == 3
	)
	;
	(
		X == 5,
		Y == 6
	)
	;
	(
		X == 6,
		Y == 3
	)
	;
	(
		X == 6,
		Y == 4
	)
	;
	(
		X == 6,
		Y == 5
	).

