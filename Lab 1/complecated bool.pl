
eval(tru,tru).
eval(fal,fal).
eval(and(E1, E2), X) :-
   eval(E1, X1) ,
   eval(E2, X2),
   (
   (X1 == X2, X=X1);
   (X1 \== X2, X = fal)).