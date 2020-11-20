


valid_table([]).
valid_table([crow(X)|Tail]):-
	validCrow(X),
	valid_table(Tail).

valid_table([nrow(X)|Tail]):-
	validNrow(X),
	valid_table(Tail).


validCrow(Blocks):-
	length(Blocks,Len),
	Len >=3,
	validCrow2(Blocks,[],_Nr).

validCrow2([],_UsedC,_Nr).
validCrow2([block(Nr,Color)|Tail],UsedC,Nr):-
	\+ member(Color,UsedC),
	validCrow2(Tail,[Color|UsedC],Nr).


validNrow(Blocks):-
	length(Blocks,Len),
	Len >=3,
	validNrow2(Blocks,_Nr,_Color).

validNrow2([],_UsedC,_Nr).
validNrow2([block(Nr,Color)|Tail],Nr,Color):-
	UsedNextNr is Nr + 1, 
	validNrow2(Tail,UsedNextNr,Color).