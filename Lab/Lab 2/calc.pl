eval(plus(X,Y),R):-
   eval(X,R1),
   eval(Y,R2),
   R is R1 + R2.

eval(min(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  R is R1 - R2.

eval(number(X),R):-
   R is X.

eval(neg(X),R):-
  R is -X.
  eval(min(number(0),X),R1),
  R is R1.
/*
Zou het volgende moeten zijn 
eval(neg(E),V):-
    eval(E,EV),
    V is -EV.
*/


eval(=(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  R1 == R2,
  R = tru.

eval(=(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  R1 \== R2,
  R = fal.


eval(and(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  R1 == tru,
  R2 == tru,
  R  = tru.

eval(and(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  (R1 == fal; R2== fal),
  R = fal.

eval(or(X,_),R):-
  eval(X,R1),
  R1 == tru,
  R = tru.

eval(or(_,Y),R):-
  eval(Y,R2),
  R2 == tru,
  R = tru.

eval(or(X,Y),R):-
  eval(X,R1),
  eval(Y,R2),
  R1 == fal,
  R2== fal,
  R = fal.

eval(not(X),R):-
  eval(X,R1),
  R1 == tru,
  R = fal.

eval(not(X),R):-
  eval(X,R1),
  R1 == fal,
  R = tru.

eval(tru,tru).
eval(fal,fal).
