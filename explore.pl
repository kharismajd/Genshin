  
:- dynamic(koord/2). /** koord(X, Y) **/
:- dynamic(action/0).

:- public(w/0).
:- public(a/0).
:- public(s/0).
:- public(d/0).

initKoord :-
	asserta(koord(10, 2)).

w :- koord(X,Y),
	X_ is X-1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)),
    action. /* Munculkan musuh pakai : enemyTriggered */
    		/* Kalau mau gerak cek dulu IsFighting(_) */
			/* Kalau isAroundBoss, langsung lawan boss */
s :- koord(X,Y),
	X_ is X+1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)),
    action.
a :- koord(X,Y),
	Y_ is Y-1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)),
    action.
d :- koord(X,Y),
	Y_ is Y+1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)),
    action.

isValid(X,Y) :-
    X >= 0,
    Y >= 0,
    map_size(Xm,Ym),
    X < Xm,
    Y < Ym.

isAroundShop :-
	speciallokasi(XShop, YShop, 'S'),
	koord(X, Y),
	(
		XShop1 is XShop + 1,
		YShop1 is YShop + 1,
		X == XShop1,
		Y == YShop1
	)
	;
	(
		XShop2 is XShop + 1,
		YShop2 is YShop,
		X == XShop2,
		Y == YShop2
	)
	;
	(
		XShop3 is XShop + 1,
		YShop3 is YShop - 1,
		X == XShop3,
		Y == YShop3
	)
	;
	(
		XShop4 is XShop,
		YShop4 is YShop + 1,
		X == XShop4,
		Y == YShop4
	)
	;
	(
		XShop5 is XShop,
		YShop5 is YShop - 1,
		X == XShop5,
		Y == YShop5
	)
	;
	(
		XShop6 is XShop - 1,
		YShop6 is YShop + 1,
		X == XShop6,
		Y == YShop6
	)
	;
	(
		XShop7 is XShop - 1,
		YShop7 is YShop,
		X == XShop7,
		Y == YShop7
	)
	;
	(
		XShop8 is XShop - 1,
		YShop8 is YShop - 1,
		X == XShop8,
		Y == YShop8
	).

isAroundBoss :-
	speciallokasi(XBoss, YBoss, 'D'),
	koord(X, Y),
	(
		XBoss1 is XBoss + 1,
		YBoss1 is YBoss + 1,
		X == XBoss1,
		Y == YBoss1
	)
	;
	(
		XBoss2 is XBoss + 1,
		YBoss2 is YBoss,
		X == XBoss2,
		Y == YBoss2
	)
	;
	(
		XBoss3 is XBoss + 1,
		YBoss3 is YBoss - 1,
		X == XBoss3,
		Y == YBoss3
	)
	;
	(
		XBoss4 is XBoss,
		YBoss4 is YBoss + 1,
		X == XBoss4,
		Y == YBoss4
	)
	;
	(
		XBoss5 is XBoss,
		YBoss5 is YBoss - 1,
		X == XBoss5,
		Y == YBoss5
	)
	;
	(
		XBoss6 is XBoss - 1,
		YBoss6 is YBoss + 1,
		X == XBoss6,
		Y == YBoss6
	)
	;
	(
		XBoss7 is XBoss - 1,
		YBoss7 is YBoss,
		X == XBoss7,
		Y == YBoss7
	)
	;
	(
		XBoss8 is XBoss - 1,
		YBoss8 is YBoss - 1,
		X == XBoss8,
		Y == YBoss8
	).

isAroundQuest :-
	speciallokasi(XQuest, YQuest, 'Q'),
	koord(X, Y),
	(
		XQuest1 is XQuest + 1,
		YQuest1 is YQuest + 1,
		X == XQuest1,
		Y == YQuest1
	)
	;
	(
		XQuest2 is XQuest + 1,
		YQuest2 is YQuest,
		X == XQuest2,
		Y == YQuest2
	)
	;
	(
		XQuest3 is XQuest + 1,
		YQuest3 is YQuest - 1,
		X == XQuest3,
		Y == YQuest3
	)
	;
	(
		XQuest4 is XQuest,
		YQuest4 is YQuest + 1,
		X == XQuest4,
		Y == YQuest4
	)
	;
	(
		XQuest5 is XQuest,
		YQuest5 is YQuest - 1,
		X == XQuest5,
		Y == YQuest5
	)
	;
	(
		XQuest6 is XQuest - 1,
		YQuest6 is YQuest + 1,
		X == XQuest6,
		Y == YQuest6
	)
	;
	(
		XQuest7 is XQuest - 1,
		YQuest7 is YQuest,
		X == XQuest7,
		Y == YQuest7
	)
	;
	(
		XQuest8 is XQuest - 1,
		YQuest8 is YQuest - 1,
		X == XQuest8,
		Y == YQuest8
	).

