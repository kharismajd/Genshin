/** enemy(id, name, level, hp, attack, defense, gold_drop, exp_drop) **/
enemy(1, slime, 1, 125, 45, 10, 155, 100).
enemy(2, goblin, 1, 175, 50, 15, 170, 150).
enemy(3, wolf, 1, 150, 55, 12, 190, 200).
enemy(4, undead, 1, 225, 35, 22, 220, 250).

/** boss(id, name, level, hp, attack, defense) **/
boss(1, undead_dragon, 30, 3000, 100, 100).

/** player(id, class, level, hp, attack, defense) **/
player(1, swordsman, 1, 500, 70, 40).
player(2, archer, 1, 450, 80, 30).
player(3, sorcerer, 1, 400, 90, 25).

/** harga(id, item_name, harga) **/
harga(1, gacha, 100).
harga(2, potion, 100).

/** level(level, exp) **/
level(1, 200).
level(2, 400).
level(3, 600).
level(4, 800).
level(5, 1000).
level(6, 1200).
level(7, 1400).
level(8, 1600).
level(9, 1800).
level(10, 2000).
level(11, 2200).
level(12, 2400).
level(13, 2600).
level(14, 2800).
level(15, 3000).
level(16, 3200).
level(17, 3400).
level(18, 3600).
level(19, 3800).
level(20, 4000).
level(21, 4200).
level(22, 4400).
level(23, 4600).
level(24, 4800).
level(25, 5000).
level(26, 5200).
level(27, 5400).
level(28, 5600).
level(29, 5800).
level(30, 9999999).
level(31, 10000000).

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