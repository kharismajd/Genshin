:-dynamic(builtmap/2).


map_size(10,10).

/* S = Lokasi store*/
/* D = Lokasi Boss*/
/* Q = Lokasi Quest*/

/*special_lokasi(X,Y,OBJ) , X = Kolom , Y = Baris */
special_lokasi(2,2, '#').
special_lokasi(3, 7, '#').
special_lokasi(10,10, '#').

/*Membuat MAP */

/*Batas Kanan*/

printMAP(X,Y) :- 
    map_size(T,L),
        X =:= T+1.
        Y =< L+1,
        write('#'),n1,
        Z  is Y+1
        printMAP(0,Z).