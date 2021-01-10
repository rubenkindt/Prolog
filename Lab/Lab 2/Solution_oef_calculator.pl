eval(plus(A,B),C):-
	eval(A,A1),
	eval(B,B1),
	C is A1+B1.

eval(min(A,B),C):-
	eval(A,A1),
	eval(B,B1),
	C is A1-B1.

eval(neg(A),C):-
	eval(A,A1),
	C is -A1.

eval(=(A,B), tru):-
	eval(A,A1),
	eval(B,B1),
	A1 == B1.
