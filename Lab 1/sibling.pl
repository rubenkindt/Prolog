father(anton,bart).
father(anton,daan).
father(anton,elisa).
father(fabian,anton).

mother(celine,bart).
mother(celine,daan).
mother(celine,gerda).
mother(gerda,hendrik).

sibling(Kind1,Kind2):-
   father(Vader,Kind1),
   mother(Moeder,Kind1),

   father(Vader,Kind2),
   mother(Moeder,Kind2),

   /* can't be same person */
   % \== is just the check while \= tries to set the variable Kind1 to the value of Kind2, return not(succesfull)
   Kind1 \== Kind2.

   

