:- dynamic(init/1). /** Tanda mulai permainan **/
:- dynamic(playerStatus/8). /** playerStatus(lv, class, maxHP, HP, attack, defense, gold, exp) **/
:- dynamic(equiped/3). /** equiped(weapon, armor, accessory) **/

:- include('fakta.pl').
:- include('inventory.pl').
:- include('shop.pl').
:- include('battle.pl').
:- include('explore.pl').

help :-
	write('Commands: '), nl,
	write('1. start      : Untuk memulai petualanganmu'), nl,
	write('2. map        : Menampilkan peta'), nl,
	write('3. status     : Menampilkan kondisi terkini'), nl,
	write('4. equip      : Memakai equipment'), nl,
	write('5. help       : Menampilkan segala bantuan'), nl,
	write('6. quit       : Meninggalkan permainan'), nl,
	write('7. w,s,a,d    : Bergerak'), nl,
	write('8. inventory  : Melihat inventory'), nl,
	write('9. drop       : Membuang barang yang ada di inventory'), nl,
	write('10. usePotion : Memakai potion untuk menambah HP'), nl,
	write('Semua commands harus diakhiri dengan tanda titik (.)'), nl.

classSelect :-
	write('Pilih class yang anda inginkan (tulis angka diakhiri titik): '), nl,
	write('1. Swordsman'), nl,
	write('2. Archer'), nl,
	write('3. Sorcerer'), nl,
	repeat,
	(read(ID),
	((ID >= 1, ID =< 3) -> 
		player(ID, Class, Level, MaxHP, Attack, Defense),
		HP is MaxHP,
		write('Kamu telah memilih '), write(Class), nl,
		asserta(playerStatus(Level, Class, MaxHP, HP, Attack, Defense, 1000, 0)),
		asserta(equiped(none, none, none)),
		asserta(koord(0,0)), /* Ganti dengan koordinat awal */
		!
	;	write('Silakan pilih yang ada di list.'), nl, 
		fail
	)
	).

start :-
	init(_),
	write('Game sudah dimulai').
start :-
	\+ init(_),
	initInventory,
	write('Selamat datang di Genshin'), nl,
	help,
	classSelect,
	asserta(init(1)).

status :- /** Kurang level up **/
	playerStatus(Level, Class, MaxHP, HP, Attack, Defense, Gold, EXP),
	equiped(Weapon, Armor, Accessory),
	write('Class   : '), write(Class), nl,
	write('Level   : '), write(Level), nl,
	write('Health  : '), write(HP), write('/'), write(MaxHP), nl,
	write('Attack  : '), write(Attack), nl,
	write('Defense : '), write(Defense), nl,
	write('Exp     : '), write(EXP), nl,
	write('Gold    : '), write(Gold), nl,
	write('Equiped weapon    : '), write(Weapon), nl,
	write('Equiped armor     : '), write(Armor), nl,
	write('Equiped accessory : '), write(Accessory), nl.


quit :-
	init(_),
	retractall(inventoryData(_,_)),
	retractall(gold(_)),
	retractall(playerStatus(_,_,_,_,_,_,_,_)),
	retractall(equiped(_,_,_)),
	retractall(init(_)).
quit :-
	\+ init(_),
	write('Game belum dimulai').
