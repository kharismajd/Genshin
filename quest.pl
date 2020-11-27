:- dynamic(isOnQuest/5).

quest :-
	\+init(_),
	write('Game belum dimulai'),
	!.

quest :-
	isOnQuest(_, _, _, _, _),
	write('Kamu sudah mengambil quest'),
	!.

quest :-
	\+isOnQuest(_, _, _, _, _),
	isFighting(_),
	write('Kamu sedang melawan monster'),
	!.

quest :-
	\+isOnQuest(_, _, _, _, _),
	\+isAroundQuest,
	write('Kamu terlalu jauh dari quest'),
	!.

quest :-
	isAroundQuest,
	\+isFighting(_),
	\+isOnQuest(_, _, _, _, _),
	random(1, 4, W),
	random(1, 4, X),
	random(1, 4, Y),
	random(1, 4, Z),
	asserta(isOnQuest(W, X, Y, Z, 0)),
	write('Quest: Kalahkan '), write(W), write(' slime '), write(X), write(' goblin '), write(Y), write(' wolf '), write(Z), write(' undead'), nl, nl,
	!.

questDone :-
	isOnQuest(_, _, _, _, Gold),
	retract(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, PlayerGold, EXP)),
	NewGold is PlayerGold + Gold,
	asserta(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, NewGold, EXP)),
	write('Kamu telah menyelesaikan quest!'), nl,
	write('Kamu mendapatkan '), write(Gold), write(' gold'), nl,
	retract(isOnQuest(_, _, _, _, _)),
	!.

questProgress(W, X, Y, Z, Gold, Name) :-
	(Name == slime ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewW is W - 1,
		(NewW >= 0 ->
			NewGold is Gold + 50
		;
			NewGold is Gold
		),
		asserta(isOnQuest(NewW, X, Y, Z, NewGold))
	;
	Name == goblin ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewX is X - 1,
		(NewX >= 0 ->
			NewGold is Gold + 100
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, NewX, Y, Z, NewGold))
	;
	Name == wolf ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewY is Y - 1,
		(NewY >= 0 ->
			NewGold is Gold + 150
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, X, NewY, Z, NewGold))
	;
	Name == undead ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewZ is Z - 1,
		(NewZ >= 0 ->
			NewGold is Gold + 200
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, X, Y, NewZ, NewGold))
	),
	isOnQuest(WNew, XNew, YNew, ZNew, _),
	((WNew =< 0, XNew =< 0, YNew =< 0, ZNew =< 0) ->
		questDone
	).