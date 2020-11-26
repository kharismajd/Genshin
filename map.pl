:- dynamic(special_lokasi/3).


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
special_lokasi(10,10, 'D').
special_lokasi(5, 4, 'Q').
special_lokasi(2, 2, 'S').

/* X = Lebar , Y = Tinggi */
/*Membuat MAP */

/*Batas Kanan*/

printMAP(X,Y) :- 
        map_size(T,L),
                X =:= T+1,
                Y =< L+1,
                write('#'),n1,
                Z  is Y+1
                printMAP(0,Z).

/*Batas Kiri */

printMAP(X,Y) :-
        map_size(_,L),
                X =:= T+1,
                Y =< L+1,
                write('#'),
                Z is X+1,
                printMAP(Z,Y).

/*Batas  Atas */

printMAP(X,Y) :-
        map_size(T,_),
                X < T + 1,
                X > 0,
                Y =:= 0,
                write('#'),
                Z is X+1,
                printMAP(Z,Y).

/*Batas Bawah */

printMAP(X,Y) :-
        map_size(T,L),
                X < T + 1,
                X > 0,
                Y =:= L+1,
                write('#'),
                Z is X+1,
                printMAP(Z,Y).
        
/*Lokasi Special*/
printMAP(X, Y) :- 
        map_size(T, L),
		X < T + 1,
		X > 0,
		Y < L + 1,
		Y > 0,
		special_lokasi(X, Y, 'P'),
		special_lokasi(X, Y, 'Q'), !,
		write('P'),
		write(' '),
		Z is X+1,
		printMAP(Z, Y).

/*Lokasi Special*/
printMAP(X, Y) :- 
        map_size(T, L),
		X < T + 1,
		X > 0,
		Y < L + 1,
		Y > 0,
		special_lokasi(X, Y, 'D'),
		write('D'),
		write(' '),
		Z is X+1,
		printMAP(Z, Y).

/*Lokasi Special*/
printMAP(X, Y) :- 
        map_size(T, L),
		X < T + 1,
		X > 0,
		Y < L + 1,
		Y > 0,
		special_lokasi(X, Y, 'S'),
		write('S'),
		write(' '),
		Z is X+1,
		printMAP(Z, Y).

/*Lokasi Special*/
printMAP(X, Y) :- 
        map_size(T, L),
		X < T + 1,
		X > 0,
		Y < L + 1,
		Y > 0,
		special_lokasi(X, Y, 'Q'),
		write('Q'),
		write(' '),
		Z is X+1,
		printMAP(Z, Y).

/*Lokasi Special*/
printMAP(X, Y) :- 
        map_size(T, L),
		X < W + 1,
		X > 0,
		Y < H + 1,
		Y > 0,
		special_lokasi(X, Y, Obj), !,
		write(Obj),
		write(' '),
		Z is X+1,
		printMAP(Z, Y).

/*Lokasi Special*/
/* Empty */
printMAP(X, Y) :- 
        map_size(T, L),
		X < W + 1,
		X > 0,
		Y < H + 1,
		Y > 0,
		(\+ special_lokasi(X, Y, _)),
		write('-'),
		Z is X+1,
		printMAP(Z, Y).




