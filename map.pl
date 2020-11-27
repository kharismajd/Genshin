:- dynamic(special_lokasi/3).

:- public(map_size/2).
:- public(map/0).

map_size(10,10).

/* S = Lokasi store*/
/* D = Lokasi Boss*/
/* Q = Lokasi Quest*/

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
print_koord(X,Y) :- koord(X,Y), !, write('P').
print_koord(X,Y) :- special_lokasi(X,Y,Z), !, write(Z).

/* Default ke spasi */
print_koord(_,_) :- write(' ').

map :-
	\+init(_),
	write('Game belum dimulai'), nl,
	!.
map :-
	init(_).
    map_size(Xm_,Ym_),
    Xm is Xm_+2, Ym is Ym_+2,
    forall(
        between(0,Ym,Y),
        (forall(
            between(0,Xm,X),
            print_koord(X,Y)
        ), nl)).
