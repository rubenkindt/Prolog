test(o(X,Y),R):-
R=b(XNew,YNew),
member(YY,[-1,0,1]),
member(XX,[-1,0,1]),
XNew is X + XX,
YNew is Y + YY.

test(p(X,Y),R):-
member(YY,[-1,0,1]),
member(XX,[-1,0,1]),
(
XX == 0
;
YY == 0
),
XNew is X + XX,
YNew is Y + YY,
R=b(XNew,YNew).
