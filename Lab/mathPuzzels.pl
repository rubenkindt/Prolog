
puzzel1(X,Y,Z):-
	numlist(1,500,L),
	member(X,L),
	member(Y,L),
	member(Z,L),
	X + Y + Z =:= 62,
	X * Y * Z =:= 2880.


puzzel2(X,Y,Z,A):-
	numlist(1,30,L),
	member(X,L),
	member(Y,L),
	member(A,L),
	member(Z,L),
	X + Y =:= 16,
	Z - A =:= 12,
	X + Z =:= 26,
	Y + A =:= 16.
