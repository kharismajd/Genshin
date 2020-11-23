:- dynamic(isFighting/1).
:- dynamic(trigerredEnemy/8). /** Musuh yang sedang dilawan. trigerredEnemy(Name, Level, MaxHP, HP, Attack, Defense, Gold_Drop, EXP_Drop) **/

/** Under construction **/
foundEnemy :- 
    trigerredEnemy(Name, Level, MaxHP, HP, Attack, Defense, Gold_Drop, EXP_Drop),
    write('You found a '),
    write(Name), nl,
    write('Level: '),
    write(Level), nl,
    write('Health: '),
    write(HP), nl,
    write('Attack: '),
    write(Attack), nl,
    write('Defense: '),
    write(Defense), nl, nl,
    write('What will you do?').

attack :-
    
