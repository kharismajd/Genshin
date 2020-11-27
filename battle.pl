:- dynamic(isFighting/1).
:- dynamic(enemySkillCooldown/1).
:- dynamic(playerSkillCooldown/1).
:- dynamic(triggeredEnemy/8). /** Musuh yang sedang dilawan. triggeredEnemy(Name, Level, MaxHP, HP, Attack, Defense, Gold_Drop, EXP_Drop) **/
:- dynamic(playerStatus/8).
:- dynamic(peluangRun/1).
:- dynamic(isFightingBoss/1).

/** Player level 1-10 **/
enemyTriggered :-
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 10,
	PlayerLevel >= 1,
	random(1, 5, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(1, 11, Mult),
	NewLevel is Level * Mult,
	NewHP is HP + (Mult * 15),
	NewAttack is Attack + (Mult * 2),
	NewDefense is Defense + (Mult * 2),
	NewGold is Gold + (Mult * 15),
	NewEXP is EXP + (Mult * 15),
	MaxHP is NewHP,
	asserta(triggeredEnemy(Name, NewLevel, MaxHP, NewHP, NewAttack, NewDefense, NewGold, NewEXP)),
	write('Kamu menemukan '), write(Name), write(' liar dengan level '), write(NewLevel), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	write('- run'), nl,
	random(1, 10, P),
	asserta(peluangRun(P)),
	asserta(isFighting(1)),
	!.

/** Player level 11-20 **/
enemyTriggered :-	
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 20,
	PlayerLevel >= 11,
	random(1, 5, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(11, 21, Mult),
	NewLevel is Level * Mult,
	NewHP is HP + (Mult * 15),
	NewAttack is Attack + (Mult * 2),
	NewDefense is Defense + (Mult * 2),
	NewGold is Gold + (Mult * 15),
	NewEXP is EXP + (Mult * 15),
	MaxHP is NewHP,
	asserta(triggeredEnemy(Name, NewLevel, MaxHP, NewHP, NewAttack, NewDefense, NewGold, NewEXP)),
	write('Kamu menemukan '), write(Name), write(' liar dengan level '), write(NewLevel), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	write('- run'), nl,
	random(1, 15, P),
	asserta(peluangRun(P)),
	asserta(isFighting(1)),
	!.

/** Player level 21-30 **/
enemyTriggered :-
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 30,
	PlayerLevel >= 21,
	random(1, 5, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(21, 31, Mult),
	NewLevel is Level * Mult,
	NewHP is HP + (Mult * 15),
	NewAttack is Attack + (Mult * 2),
	NewDefense is Defense + (Mult * 2),
	NewGold is Gold + (Mult * 15),
	NewEXP is EXP + (Mult * 15),
	MaxHP is NewHP,
	asserta(triggeredEnemy(Name, NewLevel, MaxHP, NewHP, NewAttack, NewDefense, NewGold, NewEXP)),
	write('Kamu menemukan '), write(Name), write(' liar dengan level '), write(NewLevel), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	write('- run'), nl,
	random(1, 20, P),
	asserta(peluangRun(P)),
	asserta(isFighting(1)),
	!.

bossTriggered :-
	boss(_, Name, Level, HP, Attack, Defense),
	MaxHP is HP,
	asserta(triggeredEnemy(Name, Level, MaxHP, HP, Attack, Defense, 0, 0)),
	asserta(isFightingBoss(1)),
	asserta(cannotRun(1)),
	asserta(isFighting(1)),
	asserta(peluangRun(1)),
	write('Kamu melawan boss '), write(Name), write(' dengan level '), write(Level), nl,
	write('Apa yang akan kamu lakukan?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	 !.

run :-
	\+isFighting(_),
	write('Tidak ada monster di sekitar kamu'), nl,
	!.

run :-
	isFightingBoss(_),
	write('Kamu tidak bisa lari dari bos'), nl,
	write('Semoga sudah persiapan ya..'), nl,
	!.

run :-
	isFighting(_),
	peluangRun(P),
	P > 5,
	write('Kamu gagal lari'), nl, nl,
	retract(peluangRun(_)),
	random(1, 15, NewP),
	asserta(peluangRun(NewP)),
	enemyTurn,
	!.

run :-
	isFighting(_),
	peluangRun(P),
	P =< 5,
	write('Kamu berhasil lari'), nl,
	retract(peluangRun(P)),
	retract(isFighting(_)),
	retract(triggeredEnemy(_, _, _, _, _, _, _, _)),
	!.


attack :-
	\+ isFighting(_),
	write('Tidak ada monster di sekitar untuk diserang'), nl,
	!.

attack :-
	isFighting(_),
	playerStatus(_, _, _, _, PlayerAttack, _, _, _),
	triggeredEnemy(EnemyName, _, _, EnemyHP, _, EnemyDefense, _, _),
	PlayerAttack > EnemyDefense,
	Damage is PlayerAttack - EnemyDefense,
	NewEnemyHP is EnemyHP - PlayerAttack + EnemyDefense,
	retract(triggeredEnemy(Name, Level, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(triggeredEnemy(Name, Level, MaxHP, NewEnemyHP, Attack, Defense, Gold, EXP)),
	write('Kamu menggunakan attack!'), nl,
	write(EnemyName), write(' menerima '), write(Damage), write(' damage'), nl,
	attackaftermath,
	!.

attack :-
	isFighting(_),
	playerStatus(_, _, _, _, PlayerAttack, _, _, _),
	triggeredEnemy(EnemyName, _, _, EnemyHP, _, EnemyDefense, _, _),
	PlayerAttack =< EnemyDefense,
	Damage is 1,
	NewEnemyHP is EnemyHP - 1,
	retract(triggeredEnemy(Name, Level, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(triggeredEnemy(Name, Level, MaxHP, NewEnemyHP, Attack, Defense, Gold, EXP)),
	write('Kamu menggunakan attack!'), nl,
	write(EnemyName), write(' menerima '), write(Damage), write(' damage'), nl,
	attackaftermath,
	!.

skill :-
	\+ isFighting(_),
	write('Tidak ada monster di sekitar untuk diserang'), nl,
	!.

skill :-
	playerSkillCooldown(N),
	write('Skillmu dapat digunakan dalam '), write(N), write(' turn selanjutnya'), nl,
	!.

skill :-
	isFighting(_),
	\+ playerSkillCooldown(_),
	playerStatus(_, Class, _, _, PlayerAttack, _, _, _),
	triggeredEnemy(EnemyName, _, _, EnemyHP, _, EnemyDefense, _, _),
	PlayerSkill is PlayerAttack * 2,
	PlayerSkill > EnemyDefense,
	Damage is PlayerSkill - EnemyDefense,
	NewEnemyHP is EnemyHP - PlayerSkill + EnemyDefense,
	asserta(playerSkillCooldown(4)),
	retract(triggeredEnemy(Name, Level, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(triggeredEnemy(Name, Level, MaxHP, NewEnemyHP, Attack, Defense, Gold, EXP)),
	playerSkill(Class, SkillName),
	write('Kamu menggunakan '), write(SkillName), write('!'), nl,
	write(EnemyName), write(' menerima '), write(Damage), write(' damage'), nl,
	attackaftermath,
	!.

skill :-
	isFighting(_),
	\+ playerSkillCooldown(_),
	playerStatus(_, Class, _, _, PlayerAttack, _, _, _),
	triggeredEnemy(EnemyName, _, _, EnemyHP, _, EnemyDefense, _, _),
	PlayerSkill is PlayerAttack * 2,
	PlayerSkill =< EnemyDefense,
	Damage is 1,
	NewEnemyHP is EnemyHP - 1,
	asserta(playerSkillCooldown(4)),
	retract(triggeredEnemy(Name, Level, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(triggeredEnemy(Name, Level, MaxHP, NewEnemyHP, Attack, Defense, Gold, EXP)),
	playerSkill(Class, SkillName),
	write('Kamu menggunakan '), write(SkillName), write('!'), nl,
	write(EnemyName), write(' menerima '), write(Damage), write(' damage'), nl,
	attackaftermath,
	!.

heal :-
	inventoryData(N, potion),
	N =< 0,
	write('Tidak ada potion yang tersisa'), nl,
	!.

heal :-
	inventoryData(N, potion),
	N > 0,
	playerStatus(_, _, MaxHP, HP, _, _, _, _),
	HP >= MaxHP,
	write('HP kamu sudah penuh'), nl,
	!.

heal :-
	inventoryData(N, potion),
	N > 0,
	playerStatus(_, _, MaxHP, HP, _, _, _, _),
	NewHP is HP + 200,
	NewHP >= MaxHP,
	retract(playerStatus(Lv, Class, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(playerStatus(Lv, Class, MaxHP, MaxHP, Attack, Defense, Gold, EXP)),
	retract(inventoryData(N, potion)),
	NewN is N - 1,
	asserta(inventoryData(NewN, potion)),
	write('HP kamu telah bertambah mencapai maksimal'), nl,
	!.

heal :- 
	inventoryData(N, potion),
	N > 0,
	playerStatus(_, _, MaxHP, HP, _, _, _, _),
	NewHP is HP + 200,
	NewHP < MaxHP,
	retract(playerStatus(Lv, Class, MaxHP, _, Attack, Defense, Gold, EXP)),
	asserta(playerStatus(Lv, Class, MaxHP, NewHP, Attack, Defense, Gold, EXP)),
	retract(inventoryData(N, potion)),
	NewN is N - 1,
	asserta(inventoryData(NewN, potion)),
	write('HP telah bertambah menjadi '), write(NewHP), nl,
	!.

newPlayerCooldown :-
	\+ playerSkillCooldown(_),
	!.

newPlayerCooldown :-
	playerSkillCooldown(N),
	NewCooldown is N - 1,
	NewCooldown =< 0,
	retract(playerSkillCooldown(_)),
	!.

newPlayerCooldown :-
	playerSkillCooldown(N),
	NewCooldown is N - 1,
	NewCooldown > 0,
	retract(playerSkillCooldown(N)),
	asserta(playerSkillCooldown(NewCooldown)),
	!.

newEnemyCooldown :-
	\+ enemySkillCooldown(_),
	!.

newEnemyCooldown :-
	enemySkillCooldown(N),
	NewCooldown is N - 1,
	NewCooldown =< 0,
	retract(enemySkillCooldown(_)),
	!.

newEnemyCooldown :-
	enemySkillCooldown(N),
	NewCooldown is N - 1,
	NewCooldown > 0,
	retract(enemySkillCooldown(N)),
	asserta(enemySkillCooldown(NewCooldown)),
	!.

attackaftermath :-
	isFighting(_),
	triggeredEnemy(Name, _, _, HP, _, _, _, _),
	HP > 0,
	newPlayerCooldown,
	write('Health point '), write(Name), write(' tersisa '), write(HP), nl, nl,
	write('sekarang giliran musuh'), nl,
	write('...'), nl,
	sleep(1),
	enemyTurn,
	!.

attackaftermath :-
	\+ isOnQuest(_, _, _, _, _, _),
	triggeredEnemy(Name, _, _, HP, _, _, _, _),
	HP =< 0,
	write(Name), write(' telah dikalahkan'), nl, nl,
	retract(isFighting(_)),
	retract(peluangRun(_)),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	;
		inventoryData(_, _)
	),
	(isFightingBoss(_) ->
		bossDefeated,
		retract(isFightingBoss(_)),
		!
	;
		retract(triggeredEnemy(_, _, _, _, _, _, Gold, EXP)),
		retract(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, PlayerGold, PlayerEXP)),
		NewPlayerGold is PlayerGold + Gold,
		NewPlayerEXP is PlayerEXP + EXP,
		asserta(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, NewPlayerGold, NewPlayerEXP)),
		win,
		write('                                    Kamu mendapatkan '), write(Gold), write(' Gold'), nl,
		write('                                    Kamu mendapatkan '), write(EXP), write(' Exp'), nl, nl,
		level(Lv, MaxExp),
		(NewPlayerEXP >= MaxExp ->
			levelUp
		;
			inventoryData(_,_)
		)
	),
	!.

attackaftermath :-
	isOnQuest(W, X, Y, Z, GoldQuest, ExpQuest),
	triggeredEnemy(Name, _, _, HP, _, _, _, _),
	HP =< 0,
	write(Name), write(' telah dikalahkan'), nl, nl,
	retract(isFighting(_)),
	retract(peluangRun(_)),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	;
		inventoryData(_, _)
	),
	(isFightingBoss(_) ->
		bossDefeated,
		retract(isFightingBoss(_)),
		!
	;
		retract(triggeredEnemy(_, _, _, _, _, _, Gold, EXP)),
		retract(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, PlayerGold, PlayerEXP)),
		NewPlayerGold is PlayerGold + Gold,
		NewPlayerEXP is PlayerEXP + EXP,
		asserta(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, NewPlayerGold, NewPlayerEXP)),
		win,
		write('                                    Kamu mendapatkan '), write(Gold), write(' Gold'), nl,
		write('                                    Kamu mendapatkan '), write(EXP), write(' Exp'), nl, nl,
		level(Lv, MaxExp),
		(NewPlayerEXP >= MaxExp ->
			levelUp
		;
			inventoryData(_,_)
		),
		questProgress(W, X, Y, Z, GoldQuest, ExpQuest, Name)
	),
	!.

enemyTurn :-
	\+ enemySkillCooldown(_),
	random(1, 100, Attack),
	(Attack < 30 ->
		enemyAttack
	;
		enemySkill
	),
	!.

enemyTurn :-
	enemySkillCooldown(_),
	enemyAttack,
	!.

enemyAttack :-
	playerStatus(_, _, _, PlayerHP, _, PlayerDefense, _, _),
	triggeredEnemy(Name, _, _, _, EnemyAttack, _, _, _),
	EnemyAttack >= PlayerDefense,
	Damage is EnemyAttack - PlayerDefense,
	NewHP is PlayerHP - EnemyAttack + PlayerDefense,
	retract(playerStatus(LV, Class, MaxHP, PlayerHP, Attack, PlayerDefense, Gold, EXP)),
	asserta(playerStatus(LV, Class, MaxHP, NewHP, Attack, PlayerDefense, Gold, EXP)),
	write(Name), write(' menggunakan attack!'), nl,
	write('Kamu menerima '), write(Damage), write(' damage!'), nl, nl,
	enemyattackaftermath,
	!.

enemyAttack :-
	playerStatus(_, _, _, PlayerHP, _, PlayerDefense, _, _),
	triggeredEnemy(Name, _, _, _, EnemyAttack, _, _, _),
	EnemyAttack < PlayerDefense,
	Damage is 1,
	NewHP is PlayerHP - 1,
	retract(playerStatus(LV, Class, MaxHP, PlayerHP, Attack, PlayerDefense, Gold, EXP)),
	asserta(playerStatus(LV, Class, MaxHP, NewHP, Attack, PlayerDefense, Gold, EXP)),
	write(Name), write(' menggunakan attack!'), nl,
	write('Kamu menerima '), write(Damage), write(' damage!'), nl, nl,
	enemyattackaftermath,
	!.

enemySkill :-
	playerStatus(_, _, _, PlayerHP, _, PlayerDefense, _, _),
	triggeredEnemy(Name, _, _, _, EnemyAttack, _, _, _),
	EnemySkill is EnemyAttack * 1.5,
	EnemySkill >= PlayerDefense,
	asserta(enemySkillCooldown(4)),
	Damage is EnemySkill - PlayerDefense,
	NewHP is PlayerHP - EnemySkill + PlayerDefense,
	retract(playerStatus(LV, Class, MaxHP, PlayerHP, Attack, PlayerDefense, Gold, EXP)),
	asserta(playerStatus(LV, Class, MaxHP, NewHP, Attack, PlayerDefense, Gold, EXP)),
	enemySkill(Name, SkillName),
	write(Name), write(' menggunakan '), write(SkillName), nl,
	write('Kamu menerima '), write(Damage), write(' damage!'), nl, nl,
	enemyattackaftermath,
	!.

enemySkill :-
	playerStatus(_, _, _, PlayerHP, _, PlayerDefense, _, _),
	triggeredEnemy(Name, _, _, _, EnemyAttack, _, _, _),
	EnemySkill is EnemyAttack * 1.5,
	EnemySkill < PlayerDefense,
	asserta(enemySkillCooldown(4)),
	Damage is 1,
	NewHP is PlayerHP - 1,
	retract(playerStatus(LV, Class, MaxHP, PlayerHP, Attack, PlayerDefense, Gold, EXP)),
	asserta(playerStatus(LV, Class, MaxHP, NewHP, Attack, PlayerDefense, Gold, EXP)),
	enemySkill(Name, SkillName),
	write(Name), write(' menggunakan '), write(SkillName), nl,
	write('Kamu menerima '), write(Damage), write(' damage!'), nl, nl,
	enemyattackaftermath,
	!.

enemyattackaftermath :-
	playerStatus(_, _, _, PlayerHP, _, _, _, _),
	PlayerHP > 0,
	newEnemyCooldown,
	write('Sekarang giliran kamu!'), nl,
	write('Kamu mau ngapain?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	write('- run'), nl,
	!.

enemyattackaftermath :-
	playerStatus(_, _, _, PlayerHP, _, _, _, _),
	PlayerHP =< 0,
	retract(isFighting(_)),
	retract(peluangRun(_)),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	;
		inventoryData(_, _)
	),
	lose,
	!.

bossDefeated :-
	write('                  :::   :::       :::     ::::    ::: ::::::::::: :::     :::::::::  :::    ::: '), nl,
	write('                :+:+: :+:+:    :+: :+:   :+:+:   :+:     :+:   :+: :+:   :+:    :+: :+:    :+:  '), nl,
	write('              +:+ +:+:+ +:+  +:+   +:+  :+:+:+  +:+     +:+  +:+   +:+  +:+    +:+ +:+    +:+   '), nl,
	write('             +#+  +:+  +#+ +#++:++#++: +#+ +:+ +#+     +#+ +#++:++#++: +#++:++#+  +#+    +:+    '), nl,
	write('            +#+       +#+ +#+     +#+ +#+  +#+#+#     +#+ +#+     +#+ +#+        +#+    +#+     '), nl,
	write('           #+#       #+# #+#     #+# #+#   #+#+#     #+# #+#     #+# #+#        #+#    #+#      '), nl,
	write('          ###       ### ###     ### ###    ####     ### ###     ### ###         ########        '), nl, nl,
	write('                     WOOOW, selamat! kamu telah mengalahkan boss dari game ini'), nl,
	write('                             Para monster tidak akan bisa spawn lagi...'), nl,
	write('                           Mungkin kehidupan setelah ini akan membosankan'), nl,
	quit,
	!.

levelUp :-
	playerStatus(PlayerLv, _, _, _, _, _, _, PlayerExp),
	level(PlayerLv, X),
	PlayerExp < X,
	write('                                Kamu telah naik level menjadi lv. '), write(PlayerLv), nl, nl,
	!.
levelUp :-
	playerStatus(PlayerLv, _, _, _, _, _, _, PlayerExp),
	level(PlayerLv, X),
	PlayerExp >= X,
	retract(playerStatus(PlayerLv, Class, PlayerMaxHP, HP, PlayerAttack, PlayerDefense, PlayerGold, PlayerExp)),
	NextLv is PlayerLv + 1,
	NewMaxHP is PlayerMaxHP + 30,
	NewAttack is PlayerAttack + 6,
	NewDefense is PlayerDefense + 2, 
	asserta(playerStatus(NextLv, Class, NewMaxHP, HP, NewAttack, NewDefense, PlayerGold, PlayerExp)),
	levelUp,
	!
	.

win :-
	write('             :::   :::  ::::::::  :::    :::        :::       ::: ::::::::::: ::::    ::: '), nl,
	write('            :+:   :+: :+:    :+: :+:    :+:        :+:       :+:     :+:     :+:+:   :+:  '), nl,
	write('            +:+ +:+  +:+    +:+ +:+    +:+        +:+       +:+     +:+     :+:+:+  +:+   '), nl,
	write('            +#++:   +#+    +:+ +#+    +:+        +#+  +:+  +#+     +#+     +#+ +:+ +#+    '), nl,
	write('            +#+    +#+    +#+ +#+    +#+        +#+ +#+#+ +#+     +#+     +#+  +#+#+#     '), nl,
	write('           #+#    #+#    #+# #+#    #+#         #+#+# #+#+#      #+#     #+#   #+#+#      '), nl,
	write('          ###     ########   ########           ###   ###   ########### ###    ####       '), nl, nl.

lose :- 
	write('             :::   :::  ::::::::  :::    :::          :::        ::::::::   ::::::::  :::::::::: '), nl,
	write('            :+:   :+: :+:    :+: :+:    :+:          :+:       :+:    :+: :+:    :+: :+:         '), nl,
	write('            +:+ +:+  +:+    +:+ +:+    +:+          +:+       +:+    +:+ +:+        +:+          '), nl,
	write('            +#++:   +#+    +:+ +#+    +:+          +#+       +#+    +:+ +#++:++#++ +#++:++#      '), nl,
	write('            +#+    +#+    +#+ +#+    +#+          +#+       +#+    +#+        +#+ +#+            '), nl,
	write('           #+#    #+#    #+# #+#    #+#          #+#       #+#    #+# #+#    #+# #+#             '), nl,
	write('          ###     ########   ########           ########## ########   ########  ##########       '), nl, nl,
	write('                                Yah, kamu telah mati di dunia ini...'), nl,
	write('                               Kamu akan bereinkarnasi ke dunia lain'), nl,
	write('                                          Selamat tinggal'), nl,
	write('                            Ketik start untuk memulai di dunia yang baru'), nl,
	

	quit,
	!.