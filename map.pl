
:- dynamic(special_lokasi/3).
:- dynamic(lokasi_player/3).

:- public(map_size/2).
:- public(map/0).

map_size(10,10).

/* S = Lokasi store*/
/* D = Lokasi Boss*/
/* Q = Lokasi Quest*/

/*lokasi_player(X,Y,P)*/
lokasi_player(1, 1, 'P').

/*special_lokasi(X,Y,OBJ) , X = Lebar, Y = Tinggi */
special_lokasi(6, 5, '#').
special_lokasi(6, 6, '#').
special_lokasi(6, 7, '#').
special_lokasi(7, 7, '#').
special_lokasi(3, 7, '#').
special_lokasi(3, 8, '#').
special_lokasi(3, 9, '#').
special_lokasi(2, 9, '#').
special_lokasi(10, 10, 'D').
special_lokasi(5, 4, 'Q').
special_lokasi(2, 2, 'S').

/* Menulis satu koordinat */

print_koord(0,_) :- !, write('#').
print_koord(_,0) :- !, write('#').
print_koord(X,_) :- map_size(Xm,_), X =:= Xm+2, !, write('#').
print_koord(_,Y) :- map_size(_,Ym), Y =:= Ym+2, !, write('#').

/* Player ditandai dengan P */
print_koord(X,Y) :- lokasi_player(X,Y,Z), !, write(Z).
print_koord(X,Y) :- special_lokasi(X,Y,Z), !, write(Z).

print_koord(X,Y) :-
    X > 0,
    Y > 0,
    map_size(Xm,Ym),
    X =< Xm+1,
    Y =< Ym+1,
    !, write('-').

map :-
    map_size(Xm_,Ym_),
    Xm is Xm_+2,
    Ym is Ym_+2,
    forall(between(0,Ym,Y),(forall(between(0,Xm,X),print_koord(X,Y)),nl)).