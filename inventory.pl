/** inventoryData(no_held, item_name) **/
:- dynamic(inventoryData/2).

maxInventory(100).

initInventory :-
	asserta(inventoryData(1, plastic_sword)),
	asserta(inventoryData(0, wooden_sword)),
	asserta(inventoryData(0, steel_sword)),
	asserta(inventoryData(0, golden_sword)),
	asserta(inventoryData(0, crystal_sword)),
	asserta(inventoryData(0, wooden_armor)),
	asserta(inventoryData(0, steel_armor)),
	asserta(inventoryData(0, golden_armor)),
	asserta(inventoryData(0, crystal_armor)),
	asserta(inventoryData(1, plastic_bow)),
	asserta(inventoryData(0, wooden_bow)),
	asserta(inventoryData(0, steel_bow)),
	asserta(inventoryData(0, golden_bow)),
	asserta(inventoryData(0, crystal_bow)),
	asserta(inventoryData(0, wooden_shirt)),
	asserta(inventoryData(0, steel_shirt)),
	asserta(inventoryData(0, golden_shirt)),
	asserta(inventoryData(0, crystal_shirt)),
	asserta(inventoryData(1, plastic_staff)),
	asserta(inventoryData(0, wooden_staff)),
	asserta(inventoryData(0, steel_staff)),
	asserta(inventoryData(0, golden_staff)),
	asserta(inventoryData(0, crystal_staff)),
	asserta(inventoryData(0, wooden_robe)),
	asserta(inventoryData(0, steel_robe)),
	asserta(inventoryData(0, golden_robe)),
	asserta(inventoryData(0, crystal_robe)),
	asserta(inventoryData(0, warrior_ring)),
	asserta(inventoryData(0, archer_ring)),
	asserta(inventoryData(0, sorcerer_ring)),
	asserta(inventoryData(5, potion)).

countInventory(Total) :-
   inventoryList(NumHeldList, _, _),
   countInventoryList(NumHeldList, Total).

countInventoryList([], 0).
countInventoryList([Num|Tail], Total) :-
   countInventoryList(Tail, Res),
   Total is Num + Res.

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
	ID = 32.
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
	write('Game belum dimulai'), nl,
	!.
inventory :-
	init(_),
	inventoryList(NumHeldList, ItemList, ClassList),
	write('Isi inventory: '), nl,
	writeItems(NumHeldList, ItemList, ClassList),
	!.

drop :-
	\+init(_),
	write('Game belum dimulai'), nl,
	!.
drop :-
	init(_),
	inventoryList(_, ItemList, _),
	length(ItemList, 0),
	write('Kamu tidak memiliki item apapun'), nl,
	!.
drop :-
	init(_),
	inventoryList(_, ItemList, _),
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
	write('Game belum dimulai'), nl, !.
equip :-
	init(_),
	equipmentList(_, EquipmentList, _),
	length(EquipmentList, 0),
	write('Kamu tidak memiliki equipment apapun'), nl, !.
equip :-
	init(_),
	equipmentList(_, _, ClassList),
	playerStatus(_, Class, _, _, _, _, _, _),
	\+memberchk(Class, ClassList),
	write('Kamu tidak memiliki equipment dengan class yang cocok'), nl, !.
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