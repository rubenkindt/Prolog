% from "Boolean Formulas"
eval(tru,tru).
eval(fal,fal).
eval(and(E1,E2),tru) :-
    eval(E1,tru),
    eval(E2,tru).
eval(and(E1,E2),fal) :-
    (eval(E1,fal) ; eval(E2,fal)).

eval(or(E1,_),tru) :-
    eval(E1,tru).
eval(or(E1,E2),V) :-
    eval(E1,fal),
    eval(E2,V).
    
eval(not(E1),fal) :-
    eval(E1,tru).
eval(not(E1),tru) :-
    eval(E1,fal).


eval(number(E),E).

eval(plus(E1,E2),C):-
    eval(E1,V1),
    eval(E2,V2),
    C is V1 + V2.

eval(min(E1,E2),V):-
    eval(E1,V1),
    eval(E2,V2),
    V is V1-V2.

eval(neg(E),V):-
    eval(E,EV),
    V is -EV.

eval(=(E1,E2), tru):-
    eval(E1,V1),
    eval(E2,V2),
    V1 =:= V2.
eval(=(E1,E2), fal):-
    eval(E1,V1),
    eval(E2,V2),
    V1 =\= V2.
