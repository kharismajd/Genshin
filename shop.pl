:- dynamic(isAroundShop/1).
:- dynamic(isInteracting/1).
:- dynamic(isFighting/1).

isAroundShop(1). /** Nanti hapus kalau udah ada map **/

shop :-
	\+init(_),
	write('Game belum dimulai'), nl.

shop :-
	isFighting(_),
	write('Kamu sedang melawan musuh'), nl.

shop :-
	\+isAroundShop(_),
	write('Kamu terlalu jauh dari shop'), nl.

shop :-
	isFull,
	write('Inventory kamu penuh, drop item terlebih dahulu'), nl.

shop :-
	isAroundShop(_),
	\+isFighting(_),
	\+isFull,
	asserta(isInteracting(1)),
	printShop,
	repeat,
	(read(Input),
	(Input =:= 1 ->
		playerStatus(_, _, _, _, _, _, X, _),
		(X >= 200 ->
			random(1, 27, ID),
			items(ID, _, _, ItemName, _, _, _),
			addInventory(ID),
			NewGold is X - 300,
			retract(playerStatus(Level, Class, MaxHP, HP, Attack, Defense, X, EXP)),
			asserta(playerStatus(Level, Class, MaxHP, HP, Attack, Defense, NewGold, EXP)),
			write('Anda mendapatkan '), write(ItemName), nl,
			(isFull -> 
				write('Inventory kamu penuh, terima kasih sudah berbelanja'), nl, !
			;	
				(NewGold < 200 ->
					write('Gold anda tidak cukup untuk membeli apapun, terima kasih telah berbelanja'), nl, !
				;

					write('Ingin belanja apa lagi?'), nl,
					write('Sisa gold: '), write(NewGold), nl,
					fail
				)
			)
		;	write('Gold anda tidak cukup'), nl,
			fail
		)
	;
	Input =:= 2 ->
		playerStatus(_, _, _, _, _, _, X, _),
		(X >= 200 ->
			addInventory(28),
			NewGold is X - 200,
			retract(playerStatus(Level, Class, MaxHP, HP, Attack, Defense, X, EXP)),
			asserta(playerStatus(Level, Class, MaxHP, HP, Attack, Defense, NewGold, EXP)),
			write('Anda membeli potion'), nl,
			(isFull ->
				write('Inventory kamu penuh, terima kasih sudah berbelanja'), nl, !
			;
				(NewGold < 200 ->
					write('Gold anda tidak cukup untuk membeli apapun, terima kasih telah berbelanja'), nl, !
				;

					write('Ingin belanja apa lagi?'), nl,
					write('Sisa gold: '), write(NewGold), nl,
					fail
				)
			)
		;	write('Gold anda tidak cukup'), nl,
			fail
		)
	;
	Input =:= 3 ->
		retract(isInteracting(_)),
		write('Terima kasih telah berbelanja'), nl,
		!
	;	
		write('Kami tidak punya barang tersebut, silakan pilih yang kami punya'), nl,
		fail
	)
	).

printShop :-
	playerStatus(_, Class, _, _, _, _, _, _),
	write('Selamat datang di shop, tuan '), write(Class), write('. anda ingin membeli apa?'), nl,
	write('1. Gacha'), nl,
	write('2. Potion'), nl,
	write('3. Exit'), nl,
	write('Mohon pilih sesuai nomor.'), nl.