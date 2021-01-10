%!esystant

size(5).
gt((0,4),(1,4)).
gt((1,4),(1,3)).
gt((0,3),(0,2)).
gt((0,2),(1,2)).
gt((2,0),(1,0)).
gt((2,3),(2,2)).
gt((2,4),(3,4)).
gt((2,1),(3,1)).
differ((3,2),(4,2),3).

% size(6).
% gt((1,3),(2,3)).
% gt((3,3),(2,3)).
% gt((2,3),(2,2)).
% gt((2,2),(1,2)).
% gt((2,2),(3,2)).
% differ((3,2),(4,2),3).


maximalChains(Chains):-
  size(N),
  Max is N-1,
  findall((X,Y), (between(0,Max, X),between(0,Max, Y)), Pos),
  chainsAcc(Pos,[], Chains).

chainsAcc([], Chains, Chains).

chainsAcc([P|Pos], Acc, Chains):-
  \+gt(P,_),
  !,
  chainsAcc(Pos, Acc, Chains).

chainsAcc([P|Pos], Acc, Chains):-
  gt(_, P),
  !,
  chainsAcc(Pos, Acc, Chains).

chainsAcc([P|Pos], Acc, Chains):-
  gt(P,_),
  findall(chain(C), maximalChainAt(P, C), Found),
  append(Found, Acc, NewAcc),
  chainsAcc(Pos, NewAcc, Chains).

maximalChainAt(Pos, Chain):-
  findall(X-C, (chainAt(Pos, C), length(C,X)), Chains),
  sort(Chains, [X-C|SortedChains]),
  member(X-Chain, [X-C|SortedChains]).

chainAt(Pos, [Pos]):-
  \+gt(Pos, _),
  !.

chainAt(Pos, [Pos|Chain]):-
  gt(Pos, Neighbour),
  chainAt(Neighbour, Chain).


respectInequalities(at(X,Y,C), Assignments):-
  findall(fail, (
          (gt((X,Y),(X1,Y1)),member(at(X1,Y1,Min), Assignments), Min > C)
         ), []),
  findall(fail, (
          (gt((X1,Y1),(X,Y)),member(at(X1,Y1,Max), Assignments), Max < C)
        ), []).

respectDifferences(at(X,Y,C), Assignments):-
  findall(fail, (
          differ((X1,Y1),(X,Y),D),member(at(X1,Y1,V), Assignments), Differ is abs(V-C), Differ\=D
        ), []).

mainarizumu(Sol):-
  size(N),
  Max is N-1,
  findall((X,Y), (between(0,Max, X),between(0,Max, Y)), Pos),
  mainarizumuAcc(Pos, [], Sol).

mainarizumuAcc([],Sol, Sol).
mainarizumuAcc([(X,Y)|Pos],Acc, Sol):-
  size(N),
  between(1, N, C),
  \+ member(at(X,_,C), Acc),
  \+ member(at(_,Y,C), Acc),
  respectInequalities(at(X,Y,C), Acc),
  respectDifferences(at(X,Y,C), Acc),
  mainarizumuAcc(Pos, [at(X,Y,C)|Acc], Sol).

neighbour((X,Y), (X,Y1)):-
  Y1 is Y-1;
  Y1 is Y+1.

neighbour((X,Y), (X1,Y)):-
  X1 is X-1;
  X1 is X+1.

island(Board, (X,Y), island(SortedIsle)):-
  islandsAcc(Board, [(X,Y)], [(X,Y)], Isle),
  sort(Isle, SortedIsle).

islandsAcc(_, [], Isle, Isle).
islandsAcc(Board, [(X,Y)|Border], Acc, Isle):-
  member(at(X,Y,V), Board),
  findall((A,B),
    ( neighbour((X,Y),(A,B)),
      \+ member((A,B), Acc),
      member(at(A,B,V1), Board),
      Diff is abs(V-V1),
      Diff < 2),
    Neighbours),
  append(Border, Neighbours, NewBorder),
  append(Neighbours, Acc, NewAcc),
  islandsAcc(Board, NewBorder,NewAcc, Isle).
