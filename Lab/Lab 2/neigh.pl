p(a,b).
p(b,c).
p(b,d).
p(d,c).


%Buur if 2 are same
ne(X,X).

%buur if next to eachother
ne(X,Y):-
   p(X,Y).

ne(X,Y):-
   p(Y,X).

ne(X,Y):-
   p(X,Z),
   ne(Z,Y).


path(X,X).

path(X,Y):-
   pathHelper(X,Y,Usedletters). % Usedletters zou [X] moetern zijn 

pathHelper(X,Y,Usedletters):-
   not(member(Y,Usedletters)),
   p(X,Y).

pathHelper(X,Y,Usedletters):-
   not(member(X,Usedletters)),
   p(Y,X).

pathHelper(X,Y,Usedletters):-
   append([X],Usedletters,UsedlettersNew), % Z zou append moeten worden, door pathHelper(Z,Y,[Z|UsedlettersNew]). te gebruiken
   not(member(Z,Usedletters)),
   p(X,Z),
   pathHelper(Z,Y,UsedlettersNew).


