%!esystant

% The mini-meta-interpreter without memoization.
interpret('>'(G1,G2)):- %misschien moeten deze functors als eerste komen
    G1>G2.

interpret(is(G1,G2)):-
    G1 is G2.

interpret((G1,G2)) :- !,
    interpret(G1),
    interpret(G2).

interpret(true) :- !.

interpret(Head) :-
    clause(Head,Body),
    interpret(Body).


% The mini-meta-interpreter with memoization (including for built-ins).
interpret_mem(Query) :-
	interpret_mem(Query,[],_).

interpret_mem('>'(G1,G2),Mem,['>'(G1,G2)|Mem]):-
    G1>G2.

interpret_mem(is(G1,G2),Mem,[is(G1,G2)|Mem]):-
    G1 is G2.

interpret_mem((G1,G2),Mem,MemOut) :- !, 
    interpret_mem(G1,Mem,Mem1), 
    interpret_mem(G2,Mem1,MemOut).

interpret_mem(true,Mem,Mem) :- !.


interpret_mem(Head,Mem,MemOut) :- 
    ( member(Head,Mem) ->
        MemOut = Mem
    ;
        clause(Head,Body), 
        interpret_mem(Body,Mem,Mem1),
        MemOut = [Head|Mem1]
    ).

% fib/2
fib0(0,1).
fib0(1,1).
fib0(N,F) :-
    N > 1,
    N2 is N - 2,
    fib0(N2,F2),
    N1 is N - 1,
    fib0(N1,F1),
    F is F1 + F2.

%alternatiave schrijfwijze
fib3(0,1).
fib3(1,1).
fib3(N,F) :-
    ('>'(N,1)),
    (is(N2, N - 2)), 
    fib3(N2,F2),
    (is(N1, N - 1 ))),
    fib3(N1,F1),
    (is(F, F1 + F2)). 
