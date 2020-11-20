eval(var(V),[pair(Variable,Value)|_T],R):-
  V==Variable,
  R is Value.

eval(var(V),[pair(_,_)|T],R):-
  eval(var(V),T,R).

eval(plus(X,Y),PList,R):-
  eval(X,PList,R1),
  eval(Y,PList,R2),
  R is (R1 + R2).

eval(times(X,Y),PList,R):-
  eval(X,PList,R1),
  eval(Y,PList,R2),
  R is (R1 * R2).

eval(int(X),_PList,R):-
  R is X.

eval(min(X),PList,R):-
  eval(X,PList,R1),
  R is (-R1).

eval(pow(X,Y),PList,R):-
  eval(X,PList,R1),
  eval(Y,PList,R2),
  R is (R1 ** R2).
