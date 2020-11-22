maxInventory(100).

/** enemy(name, level, hp, attack, defense, gold_drop) **/
enemy(slime, 1, 100, 10, 10, 100).
enemy(goblin, 10,  150, 20, 15, 150).
enemy(wolf, 20, 250, 30, 20, 200).
enemy(undead, 35 , 350, 50, 30, 250).

/** boss(name, level, hp, attack, defense, gold_drop, weakness) **/
boss(evil_natural_water, 20, 500, 75, 25, 1000, magic).
boss(goblin_paladin, 60, 2500, 20, 75, 2000, none).
boss(great_wolf_sif, 60, 1500, 100, 50, 3000, physical).
boss(undead_dragon, 60, 3000, 125, 100 5000, none).

/** player(name, level, hp, attack, defense) **/
player(swordsman, 1, 500, 30, 50).
player(archer, 1, 300, 50, 25).
player(sorcerer, 1, 300, 50, 25).

/** harga(item_name, harga) **/
harga(gacha, 100).
harga(potion, 100).
harga(dark_sigil, 1000).

/** equipment(job, item_name, hp_boost, attack_boost, defense_boost) **/
equipment(swordsman, plastic_sword, 0, 5, 0).
equipment(swordsman, wooden_sword, 0, 10, 0).
equipment(swordsman, steel_sword, 0, 20, 0).
equipment(swordsman, golden_sword, 0, 30, 0).
equipment(swordsman, crystal_sword, 0, 50, 0).
equipment(swordsman, wooden_armor, 50, 0, 10).
equipment(swordsman, steel_armor, 75, 0, 15).
equipment(swordsman, golden_armor, 100, 0, 25).
equipment(swordsman, crystal_armor, 200, 0, 50).
equipment(archer, plastic_bow, 0, 5, 0).
equipment(archer, wooden_bow, 0, 10, 0).
equipment(archer, steel_bow, 0, 20, 0).
equipment(archer, golden_bow, 0, 30, 0).
equipment(archer, crystal_bow, 0, 50, 0).
equipment(archer, wooden_shirt, 50, 0, 10).
equipment(archer, steel_shirt, 75, 0, 15).
equipment(archer, golden_shirt, 100, 0, 25).
equipment(archer, crystal_shirt, 200, 0, 50).
equipment(sorcerer, plastic_staff, 0, 5, 0).
equipment(sorcerer, wooden_staff, 0, 10, 0).
equipment(sorcerer, steel_staff, 0, 20, 0).
equipment(sorcerer, golden_staff, 0, 30, 0).
equipment(sorcerer, crystal_staff, 0, 50, 0).
equipment(sorcerer, wooden_robe, 50, 0, 10).
equipment(sorcerer, steel_robe, 75, 0, 15).
equipment(sorcerer, golden_robe, 100, 0, 25).
equipment(sorcerer, crystal_robe, 200, 0, 50).

/** playerSpecialAttack(job, name) **/
playerSpecialAttack(swordsman, pukul).
playerSpecialAttack(archer, tendang).
playerSpecialAttack(swordsman, hujan_air).

/** enemySpecialAttack(enemy, name) **/
/** nanti dibuat **/

/** Rencana rules **/
/** levelUp(?) :- **/
/** enemyTrigger(?) :- **/
/** bossTrigger(?) :- **/
/** attack(?) :- **/
/** specialAttack(?) :- **/
/** run(?) :- **/
/** usePotion(?) :- **/
/** buy(?) :- **/
/** sel(?) :- **/
/** dropItem(?) :- **/
/** useEquipment(?) :- **/
/** status(?) :- **/
/** interact(?) :- **/
/** map(?) :- **/
/** inventory(?) **/
/** w(?) :- **/
/** s(?) :- **/
/** a(?) :- **/
/** d(?) :- **/
/** save(?) :- **/
/** load(?) :- **/