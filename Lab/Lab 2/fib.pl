/*
fib(Max,Out):-
  Itter = 0,
  Out = 1,
  fib2(Max,Old,Itter,Out),

fib2(Max,Old, Itter,Out):-
  Itter2 is Itter + 1,
  Old2 is Out,
  Out2 is Old + Out,
  Itter2 is Itter + 1,
  Itter < Max,
  fib2(Max,Old2,Itter2,Out2).
*/

fib(1,0).
fib(2,1).
%fib(2,1).

fib(Max,Out):-
  Max>1,
  Max1 is Max - 1,
  Max2 is Max - 2,
  fib(Max1,Out1), %writenl(Out1),
  fib(Max2,Out2),
  Out is Out1 + Out2.
