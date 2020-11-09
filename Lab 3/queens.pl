% =:=   is () == is ()
%numlist(range,,list)
%permutations

queens(0,[]).

queens(1,[1]).

queens(Zijde,List):-
  Zijde>1,
  numlist(1,Zijde,List1),
  permutation(List1,List),
  safe(List,[]).


safe([],_).

safe([H|T],Accum2):- 
  safe_queens(T,H,1,[]),
  safe(T,[H|Accum2]).

safe_queens([], _, _, _).
safe_queens([Row2|Tail], Row, Col,Accumulator) :- 
						%Vertical check is overbodig door onze representatie
						%Horiz check, is overbodig door numlist

    diaCheck(Row,Col,Accumulator),   % / and \ check
    NewCol is Col + 1,
    safe_queens(Tail, Row, NewCol,[pos(Row,Col)|Accumulator]).

diaCheck(_Row,_Col,[]).
diaCheck(Row,Col,[pos(Row2,Col2)|Accum]):- % / and \
	(
	Col-Col2 =:= Row - Row2
	;
	Col-Col2 =:= Row2 - Row
	),
	diaCheck(Row,Col,Accum).
