:- dynamic(isOnQuest/6).

quest :-
	\+init(_),
	write('Game belum dimulai'),
	!.

quest :-
	isOnQuest(_, _, _, _, _, _),
	write('Kamu sudah mengambil quest'),
	!.

quest :-
	\+isOnQuest(_, _, _, _, _, _),
	isFighting(_),
	write('Kamu sedang melawan monster'),
	!.

quest :-
	\+isOnQuest(_, _, _, _, _, _),
	\+isAroundQuest,
	write('Kamu terlalu jauh dari quest'),
	!.

quest :-
	isAroundQuest,
	\+isFighting(_),
	\+isOnQuest(_, _, _, _, _, _),
	random(1, 4, W),
	random(1, 4, X),
	random(1, 4, Y),
	random(1, 4, Z),
	asserta(isOnQuest(W, X, Y, Z, 0, 0)),
	write('Quest: Kalahkan '), write(W), write(' slime, '), write(X), write(' goblin, '), write(Y), write(' wolf, '), write(Z), write(' undead'), nl, nl,
	!.

questDone :-
	isOnQuest(_, _, _, _, Gold, Exp),
	retract(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, PlayerGold, PlayerExp)),
	NewGold is PlayerGold + Gold,
	NewExp is PlayerExp + Exp, 
	asserta(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, NewGold, NewExp)),
	write('                                 Kamu telah menyelesaikan quest!'), nl,
	write('                                    Kamu mendapatkan '), write(Gold), write(' gold'), nl,
	write('                                    Kamu mendapatkan '), write(Exp), write(' exp'), nl, nl,
	retract(isOnQuest(_, _, _, _, _, _)),
	level(Lv, MaxExp),
	(NewExp >= MaxExp ->
			levelUp
	),
	!.

questProgress(W, X, Y, Z, Gold, Exp, Name) :-
	(Name == slime ->
		retract(isOnQuest(W, X, Y, Z, Gold, Exp)),
		NewW is W - 1,
		(NewW >= 0 ->
			NewGold is Gold + 50,
			NewExp is Exp + 50
		;
			NewGold is Gold,
			NewExp is Exp
		),
		asserta(isOnQuest(NewW, X, Y, Z, NewGold, NewExp))
	;
	Name == goblin ->
		retract(isOnQuest(W, X, Y, Z, Gold, Exp)),
		NewX is X - 1,
		(NewX >= 0 ->
			NewGold is Gold + 100,
			NewExp is Exp + 100
		;
			NewGold is Gold,
			NewExp is Exp
		),
		asserta(isOnQuest(W, NewX, Y, Z, NewGold, NewExp))
	;
	Name == wolf ->
		retract(isOnQuest(W, X, Y, Z, Gold, Exp)),
		NewY is Y - 1,
		(NewY >= 0 ->
			NewGold is Gold + 150,
			NewExp is Exp + 150
		;
			NewGold is Gold,
			NewExp is Exp
		),
		asserta(isOnQuest(W, X, NewY, Z, NewGold, NewExp))
	;
	Name == undead ->
		retract(isOnQuest(W, X, Y, Z, Gold, Exp)),
		NewZ is Z - 1,
		(NewZ >= 0 ->
			NewGold is Gold + 200,
			NewExp is Exp + 200
		;
			NewGold is Gold,
			NewExp is Exp
		),
		asserta(isOnQuest(W, X, Y, NewZ, NewGold, NewExp))
	),
	isOnQuest(WNew, XNew, YNew, ZNew, _, _),
	((WNew =< 0, XNew =< 0, YNew =< 0, ZNew =< 0) ->
		questDone
	).

infoQuest :-
	\+isOnQuest(_,_,_,_,_,_),
	write('Kamu belum mengambil quest'), nl,
	!.

infoQuest :-
	isOnQuest(W,X,Y,Z,_,_),
	(W =< 0 ->
		NewW is 0
	;
		NewW is W
	),
	(X =< 0 ->
		NewX is 0
	;
		NewX is X
	),
	(Y =< 0 ->
		NewY is 0
	;
		NewY is Y
	),
	(Z =< 0 ->
		NewZ is 0
	;
		NewZ is Z
	),
	write('Quest: Kalahkan '), write(NewW), write(' slime, '), write(NewX), write(' goblin, '), write(NewY), write(' wolf, '), write(NewZ), write(' undead'), nl, nl,
	!.
