prime(Max,Out):-
  createList(Max,List1),
  prepremove(Max,List1,List1,Out).

%start at 2 because 1 is no prime
createList(Max,List1):-
  High is Max-1,
  numlist(2,High,List1).

%start at 2 because if we Prime*1 we would remove the prime
prepremove(Max,[Prime|_T],List1,OutList2):-
  remove(Max,2,Prime,List1,OutList2).

prepremove(Max,[_Prime|T],List1,OutList2):-
  prepremove(Max,T,List1,OutList2),
  OutList2 = List1.

remove(_Max,Itter,Prime,List1,OutList2):-
  ToRemove is Prime * Itter,
  select(ToRemove,List1,OutList2).

remove(Max,Itter,Prime,List1,OutList2):-
  Itter2 is Itter + 1,
  Itter2 < Max,
  remove(Max,Itter2,Prime,List1,OutList2).
