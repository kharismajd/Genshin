:- dynamic(koord/2). /** koord(X, Y) **/
:- dynamic(isValid/2). /** isValid(X, Y) **/

:- public(w/0).
:- public(a/0).
:- public(s/0).
:- public(d/0).

w :- koord(X,Y),
	X_ is X-1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)).
s :- koord(X,Y),
	X_ is X+1,
	isValid(X_,Y), !,
	retractall(koord(_,_)),
	asserta(koord(X_,Y)).
a :- koord(X,Y),
	Y_ is Y-1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)).
d :- koord(X,Y),
	Y_ is Y+1,
	isValid(X,Y_), !,
	retractall(koord(_,_)),
	asserta(koord(X,Y_)).
