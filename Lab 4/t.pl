max(X,Y,Max):-
	X>=Y,Max=X,!
	;
	Max=Y.