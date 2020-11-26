:- dynamic(cannotRun/1).
:- dynamic(isFighting/1).
:- dynamic(isEnemyAlive/1).
:- dynamic(enemySkillCooldown/1).
:- dynamic(playerSkillCooldown/1).
:- dynamic(triggeredEnemy/8). /** Musuh yang sedang dilawan. triggeredEnemy(Name, Level, MaxHP, HP, Attack, Defense, Gold_Drop, EXP_Drop) **/
:- dynamic(playerStatus/8).
:- dynamic(peluangRun/1).
:- dynamic(isFightingBoss/1).
:- dynamic(isOnQuest/4).


/** Player level 1-10 **/
enemyTriggered :-
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 10,
	PlayerLevel >= 1,
	random(1, 4, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(1, 10, Mult),
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
	write('- fight'), nl,
	write('- run'), nl,
	random(1, 10, P),
	asserta(peluangRun(P)),
	asserta(isEnemyAlive(1)),
	!.

/** Player level 11-20 **/
enemyTriggered :-	
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 20,
	PlayerLevel >= 11,
	random(1, 4, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(11, 20, Mult),
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
	write('- fight'), nl,
	write('- run'), nl,
	random(1, 15, P),
	asserta(peluangRun(P)),
	asserta(isEnemyAlive(1)),
	!.

/** Player level 21-30 **/
enemyTriggered :-
	playerStatus(PlayerLevel, _, _, _, _, _, _, _),
	PlayerLevel =< 30,
	PlayerLevel >= 21,
	random(1, 4, ID),
	enemy(ID, Name, Level, HP, Attack, Defense, Gold, EXP),
	random(21, 30, Mult),
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
	write('- fight'), nl,
	write('- run'), nl,
	random(1, 20, P),
	asserta(peluangRun(P)),
	asserta(isEnemyAlive(1)),
	!.

bossTriggered :-
	boss(_, Name, Level, HP, Attack, Defense),
	MaxHP is HP,
	asserta(triggeredEnemy(Name, Level, MaxHP, HP, Attack, Defense, 0, 0)),
	asserta(isFightingBoss(1)),
	asserta(cannotRun(1)),
	asserta(isEnemyAlive(1)),
	asserta(peluangRun(1)),
	write('Kamu melawan boss '), write(Name), write(' dengan level '), write(Level), nl,
	fight, !.

run :-
	\+isEnemyAlive(_),
	write('Tidak ada monster di sekitar kamu'), nl,
	!.

run :-
	\+ cannotRun(_),
	isEnemyAlive(_),
	peluangRun(P),
	P > 5,
	write('Kamu gagal lari'), nl,
	fight,
	!.

run :-
	\+ cannotRun(_),
	isEnemyAlive(_),
	peluangRun(P),
	P =< 5,
	write('Kamu berhasil lari'), nl,
	retract(peluangRun(P)),
	retract(isEnemyAlive(_)),
	retract(triggeredEnemy(_, _, _, _, _, _, _, _)),
	!.

run :-
	cannotRun(_),
	write('Kamu sudah gagal lari, semangat lawan monsternya!'), nl,
	!.

fight :-
	\+isEnemyAlive(_),
	write('Tidak ada monster di sekitar kamu'), nl,
	!.

fight :-
	isFighting(_),
	isEnemyAlive(_),
	write('Kamu harus melawan monster itu'), nl,
	!.

fight :-
	\+isFighting(_),
	isEnemyAlive(_),
	asserta(isFighting(1)),
	asserta(cannotRun(_)),
	retract(peluangRun(_)),
	write('Semangat melawan monsternya!'), nl,
	write('Kamu mau ngapain?'), nl,
	write('- attack'), nl,
	write('- skill'), nl,
	write('- heal'), nl,
	!.

attack :-
	\+ isEnemyAlive(_),
	write('Tidak ada monster di sekitar untuk diserang'), nl,
	!.

attack :-
	isEnemyAlive(_),
	\+ isFighting(_),
	write('Fight dulu, baru serang'), nl,
	!.

attack :-
	isEnemyAlive(_),
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
	isEnemyAlive(_),
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
	\+ isEnemyAlive(_),
	write('Tidak ada monster di sekitar untuk diserang'), nl,
	!.

skill :-
	isEnemyAlive(_),
	\+ isFighting(_),
	write('Fight dulu, baru serang'), nl,
	!.

skill :-
	playerSkillCooldown(N),
	write('Skillmu dapat digunakan dalam '), write(N), write(' turn selanjutnya'), nl,
	!.

skill :-
	isEnemyAlive(_),
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
	isEnemyAlive(_),
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
	isEnemyAlive(_),
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
	\+ isOnQuest(_, _, _, _),
	triggeredEnemy(Name, _, _, HP, _, _, _, _),
	HP =< 0,
	write(Name), write(' telah dikalahkan'), nl, nl,
	retract(isFighting(_)),
	retract(isEnemyAlive(_)),
	retract(cannotRun(_)),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	),
	(isFightingBoss(_) ->
		bossDefeated,
		!
	;
		retract(triggeredEnemy(_, _, _, _, _, _, Gold, EXP)),
		retract(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, PlayerGold, PlayerEXP)),
		NewPlayerGold is PlayerGold + Gold,
		NewPlayerEXP is PlayerEXP + EXP,
		asserta(playerStatus(Lv, Class, MaxHP, PlayerHP, Attack, Defense, NewPlayerGold, NewPlayerEXP)),
		write('Kamu mendapatkan '), write(Gold), write(' Gold'), nl,
		write('Kamu mendapatkan '), write(EXP), write(' Exp'), nl
	),
	!.

attackaftermath :-
	isOnQuest(_, _, _, _),
	triggeredEnemy(Name, _, _, HP, _, _, _, _),
	HP =< 0,
	write(Name), write(' telah dikalahkan'), nl,
	retract(isFighting(_)),
	retract(isEnemyAlive(_)),
	retract(cannotRun(_)),
	(Name == slime ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewW is W - 1,
		(NewW >= 0 ->
			NewGold is Gold + 50
		;
			NewGold is Gold
		),
		asserta(isOnQuest(NewW, X, Y, NewGold))
	;
	Name == goblin ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewX is X - 1,
		(NewX >= 0 ->
			NewGold is Gold + 100
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, NewX, Y, Z, Gold))
	;
	Name == wolf ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewY is Y - 1,
		(NewY >= 0 ->
			NewGold is Gold + 150
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, X, NewY, Z, Gold))
	;
	Name == undead ->
		retract(isOnQuest(W, X, Y, Z, Gold)),
		NewZ is Z - 1,
		(NewZ >= 0 ->
			NewGold is Gold + 200
		;
			NewGold is Gold
		),
		asserta(isOnQuest(W, X, Y, NewZ, Gold))
	),

	isOnQuest(W, X, Y, Z, Gold),
	(W =< 0, X =< 0, Y =< 0, Z =< 0 ->
		questDone
	),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	),
	(isFightingBoss(_) ->
		bossDefeated,
		!
	;
		retract(triggeredEnemy(_, _, _, _, _, _, Gold, EXP)),
		retract(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, PlayerGold, PlayerEXP)),
		NewPlayerGold is PlayerGold + Gold,
		NewPlayerEXP is PlayerEXP + EXP,
		asserta(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, NewPlayerGold, NewPlayerEXP)),
		write('Kamu mendapatkan '), write(Gold), write(' Gold'), nl,
		write('Kamu mendapatkan '), write(Gold), write(' Gold'), nl
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
	EnemySkill is EnemyAttack * 2,
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
	EnemySkill is EnemyAttack * 2,
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
	!.

enemyattackaftermath :-
	playerStatus(_, _, _, PlayerHP, _, _, _, _),
	PlayerHP =< 0,
	retract(isFighting(_)),
	retract(isEnemyAlive(_)),
	retract(cannotRun(_)),
	(playerSkillCooldown(_) ->
		retract(playerSkillCooldown(_))
	;
	enemySkillCooldown(_) ->
		retract(enemySkillCooldown(_))
	),
	lose,
	!.

questDone :-
	isOnQuest(_, _, _, _, Gold),
	retract(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, PlayerGold, EXP)),
	NewGold is PlayerGold + Gold,
	asserta(playerStatus(Lv, Class, MaxHP, HP, Attack, Defense, NewGold, EXP)),
	write('Kamu telah menyelesaikan quest!'), nl,
	write('Kamu mendapatkan '), write(Gold), write(' gold'), nl,
	!.

bossDefeated :-
	write('WOOOW, selamat! kamu telah mengalahkan boss dari game ini'), nl,
	write('Para monster tidak akan bisa spawn lagi...'), nl,
	write('Mungkin kehidupan setelah ini akan membosankan'), nl,
	write('Ketik start untuk merevive boss lagi'), nl,
	quit,
	!.

lose :-
	write('Yah, kamu telah mati di dunia ini...'), nl,
	write('Kamu akan bereinkarnasi ke dunia lain'), nl,
	write('Selamat tinggal'), nl,
	quit,
	fail,
	!.


























