highway(1,2,yellow).
highway(2,3,blue).
highway(1,3,yellow).

check():-
  highway(N,_,_),
  check_even_at(N),
  check_colors_at(N).

check():- fail.


check_even_at(N):- 
  amountBuren(N,Lengte),
  Lengte rem 2 =:=0.

check_even_at(_N):- fail.


check_colors_at(Node):-
  nodesColor(Node,Color),
  findall(Color, highway(_,Node,Color); highway(Node,_,Color),ColorsList),
  length(ColorsList,ColorLengte),
  amountBuren(Node,AantalBuren),
  \+ (AantalBuren > ColorLengte / 2).

check_colors_at(_N):- fail.

nodesColor(Node,Color):-
  highway(Node,_,Color).




amountBuren(Node,AmoutBuren):-
  findall(Node, highway(_,Node,_); highway(Node,_,_),BurenList),
  length(BurenList,AmoutBuren).
