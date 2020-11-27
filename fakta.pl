/** enemy(id, name, level, hp, attack, defense, gold_drop, exp_drop) **/
enemy(1, slime, 1, 125, 55, 10, 155, 50).
enemy(2, goblin, 1, 175, 60, 15, 170, 75).
enemy(3, wolf, 1, 150, 65, 12, 190, 100).
enemy(4, undead, 1, 225, 45, 22, 220, 125).

/** boss(id, name, level, hp, attack, defense) **/
boss(1, undead_dragon, 30, 5000, 300, 100).

/** player(id, class, level, hp, attack, defense) **/
player(1, swordsman, 1, 500, 70, 40).
player(2, archer, 1, 450, 80, 30).
player(3, sorcerer, 1, 400, 90, 25).

/** harga(id, item_name, harga) **/
harga(1, gacha, 100).
harga(2, potion, 100).

/** level(level, exp) **/
level(1, 100).
level(2, 200).
level(3, 400).
level(4, 700).
level(5, 1100).
level(6, 1600).
level(7, 2300).
level(8, 3100).
level(9, 4000).
level(10, 5000).
level(11, 6100).
level(12, 7300).
level(13, 8600).
level(14, 10000).
level(15, 11500).
level(16, 13100).
level(17, 14800).
level(18, 16600).
level(19, 18500).
level(20, 20500).
level(21, 22600).
level(22, 24800).
level(23, 27100).
level(24, 29500).
level(25, 32000).
level(26, 34600).
level(27, 37300).
level(28, 40100).
level(29, 43000).
level(30, 9999999).

/** items(id, class, type,  item_name, maxhp_boost, attack_boost, defense_boost) **/
items(1, swordsman, weapon, plastic_sword, 0, 5, 0).
items(2, swordsman, weapon, wooden_sword, 0, 10, 0).
items(3, swordsman, weapon, steel_sword, 0, 15, 0).
items(4, swordsman, weapon, golden_sword, 0, 20, 0).
items(5, swordsman, weapon, crystal_sword, 0, 30, 0).
items(6, swordsman, armor, wooden_armor, 50, 0, 5).
items(7, swordsman, armor, steel_armor, 75, 0, 10).
items(8, swordsman, armor, golden_armor, 100, 0, 15).
items(9, swordsman, armor, crystal_armor, 200, 0, 25).
items(10, archer, weapon, plastic_bow, 0, 5, 0).
items(11, archer, weapon, wooden_bow, 0, 10, 0).
items(12, archer, weapon, steel_bow, 0, 15, 0).
items(13, archer, weapon, golden_bow, 0, 20, 0).
items(14, archer, weapon, crystal_bow, 0, 30, 0).
items(15, archer, armor, wooden_shirt, 50, 0, 5).
items(16, archer, armor, steel_shirt, 75, 0, 10).
items(17, archer, armor, golden_shirt, 100, 0, 15).
items(18, archer, armor, crystal_shirt, 200, 0, 25).
items(19, sorcerer, weapon, plastic_staff, 0, 5, 0).
items(20, sorcerer, weapon, wooden_staff, 0, 10, 0).
items(21, sorcerer, weapon, steel_staff, 0, 15, 0).
items(22, sorcerer, weapon, golden_staff, 0, 20, 0).
items(23, sorcerer, weapon, crystal_staff, 0, 30, 0).
items(24, sorcerer, armor, wooden_robe, 50, 0, 5).
items(25, sorcerer, armor, steel_robe, 75, 0, 10).
items(26, sorcerer, armor, golden_robe, 100, 0, 15).
items(27, sorcerer, armor, crystal_robe, 200, 0, 25).
items(28, swordsman, accessory, warrior_ring, 65, 15, 15).
items(29, archer, accessory, archer_ring, 40, 25, 10).
items(30, sorcerer, accessory, sorcerer_ring, 30, 35, 5).
items(31, all, consumables, potion, 0, 0, 0).
items(32, _, _, none, 0, 0, 0).

/** playerSpecialAttack(job, name) **/
playerSkill(swordsman, pukul).
playerSkill(archer, tendang).
playerSkill(sorcerer, hujan_air).

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