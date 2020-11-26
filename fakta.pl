/** enemy(id, name, level, hp, attack, defense, gold_drop, exp_drop) **/
enemy(1, slime, 1, 125, 20, 10, 100, 100).
enemy(2, goblin, 1, 200, 15, 15, 150, 150).
enemy(3, wolf, 1, 175, 30, 30, 12, 200).
enemy(4, undead, 1, 275, 10, 22, 250, 250).

/** boss(id, name, level, hp, attack, defense) **/
boss(1, undead_dragon, 30, 3000, 125, 100).

/** player(id, class, level, hp, attack, defense) **/
player(1, swordsman, 1, 500, 40, 50).
player(2, archer, 1, 400, 50, 25).
player(3, sorcerer, 1, 400, 50, 25).

/** harga(id, item_name, harga) **/
harga(1, gacha, 100).
harga(2, potion, 100).
harga(3, dark_sigil, 1000).

/** items(id, class, type,  item_name, maxhp_boost, attack_boost, defense_boost) **/
items(1, swordsman, weapon, plastic_sword, 0, 5, 0).
items(2, swordsman, weapon, wooden_sword, 0, 10, 0).
items(3, swordsman, weapon, steel_sword, 0, 20, 0).
items(4, swordsman, weapon, golden_sword, 0, 30, 0).
items(5, swordsman, weapon, crystal_sword, 0, 50, 0).
items(6, swordsman, armor, wooden_armor, 50, 0, 10).
items(7, swordsman, armor, steel_armor, 75, 0, 15).
items(8, swordsman, armor, golden_armor, 100, 0, 25).
items(9, swordsman, armor, crystal_armor, 200, 0, 50).
items(10, archer, weapon, plastic_bow, 0, 5, 0).
items(11, archer, weapon, wooden_bow, 0, 10, 0).
items(12, archer, weapon, steel_bow, 0, 20, 0).
items(13, archer, weapon, golden_bow, 0, 30, 0).
items(14, archer, weapon, crystal_bow, 0, 50, 0).
items(15, archer, armor, wooden_shirt, 50, 0, 10).
items(16, archer, armor, steel_shirt, 75, 0, 15).
items(17, archer, armor, golden_shirt, 100, 0, 25).
items(18, archer, armor, crystal_shirt, 200, 0, 50).
items(19, sorcerer, weapon, plastic_staff, 0, 5, 0).
items(20, sorcerer, weapon, wooden_staff, 0, 10, 0).
items(21, sorcerer, weapon, steel_staff, 0, 20, 0).
items(22, sorcerer, weapon, golden_staff, 0, 30, 0).
items(23, sorcerer, weapon, crystal_staff, 0, 50, 0).
items(24, sorcerer, armor, wooden_robe, 50, 0, 10).
items(25, sorcerer, armor, steel_robe, 75, 0, 15).
items(26, sorcerer, armor, golden_robe, 100, 0, 25).
items(27, sorcerer, armor, crystal_robe, 200, 0, 50).
items(28, all, consumables, potion, 0, 0, 0).
items(29, _, _, none, 0, 0, 0).

/** playerSpecialAttack(job, name) **/
playerSkill(swordsman, pukul).
playerSkill(archer, tendang).
playerSkill(swordsman, hujan_air).

/** enemySpecialAttack(enemy, name) **/
enemySkill(slime, smol_water_cannon).
enemySkill(goblin, pentung).
enemySkill(wolf, howl_castle).
enemySkill(undead, tampol).
enemySkill(undead_dragon, bonkah_bengu).

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