
highway(1,2,c).
highway(2,3,a).
highway(1,3,b).
highway(3,5,a).
highway(3,4,c).
highway(5,4,d).

check_even_at(N) :-
	findall(M, highway(N, M, _C1) ; highway(M, N, _C2), MList),
	length(MList, Amount),
	Amount rem 2 =:= 0.

count_color(N, C, L) :-
	findall(M, highway(N, M, C) ; highway(M, N, C), MList),
	length(MList, L).

check_colors_at(N) :-
	findall(C, highway(N, _M1, C) ;  highway(_M2, N, C), CList),
	length(CList, L1),
	forall(
		(
			member(C, CList), count_color(N,C,L2)
		),
		L2 =< div(L1, 2)
	).

% check if for all nodes
% 1) the nodes have an even number of connections.
% 2) same collored connections <= different collored connections
check :-
	forall(
		(
			highway(N, _M1, _C1); highway(_M2, N, _C2)
		), (
			check_even_at(N), check_colors_at(N)
		)
	).

