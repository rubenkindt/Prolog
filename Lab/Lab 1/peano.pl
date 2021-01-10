peano_plus(zero,X,X).
peano_plus(s(X),Y,s(Z)) :- peano_plus(X,Y,Z).

min(X,zero,X).
min(s(X),s(Y),Z):-
   min(X,Y,Z).

greater_than(Big,Small):-
   min(Big,Small,Z),
   Z \= zero.

greater_thanSec(Big,Small):-
   Big \= zero,
   Small = zero.
greater_thanSec(s(Big), s(Small)):-
   greater_thanSec(Big,Small).

%negatio (\=) gives errors,difficult
greater_thanBetter(Big,Small):-
   min(Big,Small,s(_)).

max(X,zero,X).
max(zero,Y,Y).
max(s(X),s(Y),s(Z)):-
   max(X,Y,Z).
   
%wrong name for testfile
maximum(X,Y,Z):-
    max(X,Y,Z).
