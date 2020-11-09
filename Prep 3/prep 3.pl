conc([], L1, L1).
conc([X | L1], L2, [X | L3]) :-conc( L1, L2,L3).


aappend([L1|[_|[_|[]]]],L1).
%aappend([_|[_|[]]],[]).
%aappend([_|[]],[]).
%aappend([],[]).

aappend([_|L1],R):- aappend(L1,R).


last([H|[]],H).
last([_H|T],R):- last(T,R).

evenLength([_H|[_H1|[]]]).
evenLength([_H|[_H1|T]]):- evenLength(T).


oddLength([_H|[]]).
oddLength([_H|[_H2|[_H1|T]]]):- evenLength(T).

