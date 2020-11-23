/** inventoryData(no_held, item_name) **/
:- dynamic(inventoryData/2).

maxInventory(100).

initInventory :-
	asserta(inventoryData(0, plastic_sword)),
	asserta(inventoryData(0, wooden_sword)),
	asserta(inventoryData(0, steel_sword)),
	asserta(inventoryData(0, golden_sword)),
	asserta(inventoryData(0, crystal_sword)),
	asserta(inventoryData(0, wooden_armor)),
	asserta(inventoryData(0, steel_armor)),
	asserta(inventoryData(0, golden_armor)),
	asserta(inventoryData(0, crystal_armor)),
	asserta(inventoryData(0, plastic_bow)),
	asserta(inventoryData(0, wooden_bow)),
	asserta(inventoryData(0, steel_bow)),
	asserta(inventoryData(0, golden_bow)),
	asserta(inventoryData(0, crystal_bow)),
	asserta(inventoryData(0, wooden_shirt)),
	asserta(inventoryData(0, steel_shirt)),
	asserta(inventoryData(0, golden_shirt)),
	asserta(inventoryData(0, crystal_shirt)),
	asserta(inventoryData(0, plastic_staff)),
	asserta(inventoryData(0, wooden_staff)),
	asserta(inventoryData(0, steel_staff)),
	asserta(inventoryData(0, golden_staff)),
	asserta(inventoryData(0, crystal_staff)),
	asserta(inventoryData(0, wooden_robe)),
	asserta(inventoryData(0, steel_robe)),
	asserta(inventoryData(0, golden_robe)),
	asserta(inventoryData(0, crystal_robe)),
	asserta(inventoryData(0, potion)).

countInventory(Total) :-
	Number is 0,
	inventoryData(X, plastic_sword),
	Number1 is Number + X,
	inventoryData(X1, wooden_sword),
	Number2 is Number1 + X1,
	inventoryData(X2, steel_sword),
	Number3 is Number2 + X2,
	inventoryData(X3, golden_sword),
	Number4 is Number3 + X3,
	inventoryData(X4, crystal_sword),
	Number5 is Number4 + X4,
	inventoryData(X5, wooden_armor),
	Number6 is Number5 + X5,
	inventoryData(X6, steel_armor),
	Number7 is Number6 + X6,
	inventoryData(X7, golden_armor),
	Number8 is Number7 + X7,
	inventoryData(X8, crystal_armor),
	Number9 is Number8 + X8,
	inventoryData(X9, plastic_bow),
	Number10 is Number9 + X9,
	inventoryData(X10, wooden_bow),
	Number11 is Number10 + X10,
	inventoryData(X11, steel_bow),
	Number12 is Number11 + X11,
	inventoryData(X12, golden_bow),
	Number13 is Number12 + X12,
	inventoryData(X13, crystal_bow),
	Number14 is Number13 + X13,
	inventoryData(X14, wooden_shirt),
	Number15 is Number14 + X14,
	inventoryData(X15, steel_shirt),
	Number16 is Number15 + X15,
	inventoryData(X15, golden_shirt),
	Number17 is Number16 + X15,
	inventoryData(X16, crystal_shirt),
	Number18 is Number17 + X16,
	inventoryData(X17, plastic_staff),
	Number19 is Number18 + X17,
	inventoryData(X18, wooden_staff),
	Number20 is Number19 + X18,
	inventoryData(X19, steel_staff),
	Number21 is Number20 + X19,
	inventoryData(X20, golden_staff),
	Number22 is Number21 + X20,
	inventoryData(X21, crystal_staff),
	Number23 is Number22 + X21,
	inventoryData(X22, wooden_robe),
	Number24 is Number23 + X22,
	inventoryData(X23, steel_robe),
	Number25 is Number24 + X23,
	inventoryData(X24, golden_robe),
	Number26 is Number25 + X24,
	inventoryData(X25, crystal_robe),
	Number27 is Number26 + X25,
	inventoryData(X26, potion),
	Total is Number27 + X26.

isFull :-
	countInventory(Number),
	maxInventory(Max),
	Number == Max.

addInventory(_) :-
	countInventory(Number),
	maxInventory(Max),
	Number >= Max,
	write('Inventory sudah penuh').
addInventory(ID) :-
	ID = 29.
addInventory(ID) :-
	items(ID, _, _, Item, _, _, _),
	inventoryData(Num, Item),
	Newnum is Num + 1,
	retract(inventoryData(Num, Item)),
	asserta(inventoryData(Newnum, Item)).

deleteItems(Item, N) :-
	inventoryData(Num, Item),
	Newnum is Num - N,
	retract(inventoryData(_, Item)),
	asserta(inventoryData(Newnum, Item)).

inventoryList(NumHeldList, ItemList, ClassList) :-
	findall(Num, (inventoryData(Num, _), Num \= 0), NumHeldList),
	findall(Item, (inventoryData(Num, Item), Num \= 0), ItemList),
	findall(Class, (inventoryData(Num, Item), items(_, Class, _, Item, _, _, _), Num \= 0), ClassList).

equipmentList(NumHeldList, EquipmentList, ClassList) :-
	findall(Num, (inventoryData(Num, Equipment), items(_, _, Type, Equipment, _, _, _), Num \= 0, Type \= consumables), NumHeldList),
	findall(Equipment, (inventoryData(Num, Equipment), items(_, _, Type, Equipment, _, _, _), Num \= 0, Type \= consumables), EquipmentList),
	findall(Class, (inventoryData(Num, Equipment), items(_, Class, Type, Equipment, _, _, _), Num \= 0, Type \= consumables), ClassList).

writeItems([], [], []).
writeItems([Num|Tail1], [Item|Tail2], [Class|Tail3]) :-
	write(Num), write(' '), write(Item), write('   ('), write(Class), write(')'), nl,
	writeItems(Tail1, Tail2, Tail3).

printEquipment :-
	\+init(_),
	write('Game belum dimulai').
printEquipment :-
	init(_),
	equipmentList(NumHeldList, EquipmentList, ClassList),
	write('Equipment di inventory: '), nl,
	writeItems(NumHeldList, EquipmentList, ClassList).

inventory :-
	\+init(_),
	write('Game belum dimulai').
inventory :-
	init(_),
	inventoryList(NumHeldList, ItemList, ClassList),
	write('Isi inventory: '), nl,
	writeItems(NumHeldList, ItemList, ClassList).

drop :-
	\+init(_),
	write('Game belum dimulai').
drop :-
	init(_),
	inventoryList(_, ItemList),
	write('Ketik item yang ingin kamu buang!'), nl,
	inventory,
	repeat,
		read(Item),
		(\+memberchk(Item, ItemList) -> write('Kamu tidak memiliki item tersebut.'), nl, fail;
	(memberchk(Item, ItemList)),
	inventoryData(ItemNum, Item),
	write('Berapa banyak yang ingin kamu buang?'), nl,
	repeat,
		read(Num),
		(Num < 0 -> write('Kamu tidak dapat membuang barang dengan nilai negatif'), nl, fail;
		Num > ItemNum -> write('Kamu tidak dapat membuang barang melebihi yang kamu miliki'), nl, fail;
	(Num >= 0, Num =< ItemNum),
	call(deleteItems(Item, Num))), !).

equip :- 
	\+init(_),
	write('Game belum dimulai').
equip :-
	init(_),
	equipmentList(_, EquipmentList, _),
	playerStatus(_, Class, _, _, _, _, _, _),
	write('Ketik equipment yang ingin dipakai'), nl,
	printEquipment,
	repeat,
	(read(Input),
	(\+memberchk(Input, EquipmentList) ->
		write('Kamu tidak dapat memilih equipment di luar list'), nl,
		fail
	;
	(items(_, EquipmentClass, _, Input, _, _, _), Class \= EquipmentClass) ->
		write('Class tidak cocok'), nl,
		fail
	;
		items(_, EquipmentClass, EquipmentType, Input, MaxHPBoost, AttackBoost, DefenseBoost),
		(EquipmentType == weapon ->
			retract(equiped(OldEquipment, Armor, Accessory)),
			asserta(equiped(Input, Armor, Accessory))
		;
		EquipmentType == armor ->
			retract(equiped(Weapon, OldEquipment, Accessory)),
			asserta(equiped(Weapon, Input, Accessory))
		;
		EquipmentType == accessory ->
			retract(equiped(Weapon, Armor, OldEquipment)),
			asserta(equiped(Weapon, Armor, Input))
		),
		items(ID, _, _, OldEquipment, OldMaxHPBoost, OldAttackBoost, OldDefenseBoost),
		playerStatus(Level, Class, MaxHP, HP, Attack, Defense, Gold, EXP),
		addInventory(ID),
		deleteItems(Input, 1),
		NewMaxHP is MaxHP - OldMaxHPBoost + MaxHPBoost,
		NewAttack is Attack - OldAttackBoost + AttackBoost,
		NewDefense is Defense - OldDefenseBoost + DefenseBoost,
		retract(playerStatus(_, _, _, _, _, _, _, _)),
		asserta(playerStatus(Level, Class, NewMaxHP, HP, NewAttack, NewDefense, Gold, EXP)),
		write('Berhasil menggunakan '), write(Input), nl,
		!
	)
	).



