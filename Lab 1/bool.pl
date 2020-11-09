
%true is true
eval(tru,tru).
eval(fal,fal).

%if not(B) is true then B is false
eval(not(B),tru):-  eval(B, fal).
eval(not(B),fal):-  eval(B, tru).

%if and(B1,B2) is true then B1 and B2 have to be true
eval(and(B1,B2),tru):-
   eval(B1,tru),
   eval(B2,tru).

%if and(B1,B2) is false then B1 OR B2 have to be false
eval(and(B1,B2),fal):-
   eval(B1,fal);
   eval(B2,fal).

%or(B1,B2) is true when B1 or B2 is true
eval(or(B1,B2),tru):-
   eval(B1,tru);
   eval(B2,tru).
