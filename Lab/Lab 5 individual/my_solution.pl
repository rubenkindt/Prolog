
valid_table([]).
valid_table(Table):-
	\+ (member(Row, Table),invalid_crow_sol(Row)),
	\+ (member(Row, Table),invalid_nrow_sol(Row)).

%Crow fails when 2diff nr's
invalid_crow_sol(crow(Crow)):-
	select(block(Nr1,_),Crow,RemRow),
	select(block(Nr2,_),RemRow,_),
	Nr1\=Nr2.

	%2 Crow fials when same colors
invalid_crow_sol(crow(Crow)):-
	select(block(_,Color1),Crow,RemRow),
	select(block(_,Color1),RemRow,_).

	%row fails has length < 3
invalid_crow_sol(crow(Crow)):-
	length(Crow,Len),
	Len<3.


%Crow fails when diff colors
invalid_nrow_sol(nrow(Nrow)):-
	select(block(_,Color1),Nrow,RemRow),
	select(block(_,Color2),RemRow,_),
	Color1\=Color2.

	%2 Crow fails when not sorted sequence of nr's
invalid_nrow_sol(nrow(Nrow)):-
	findall(Num,member(block(Num,_),Nrow),NumList),
	min_list(Numlist,Min),
	max_list(Numlist,Max),
	numlist(Min,Max,Sorted),
	Sorted\=NumList.

	%row fails has length < 3
invalid_nrow_sol(nrow(Nrow)):-
	length(Nrow,Len),
	Len<3.






%create color row
playgame(p1(Blocks,[Act|Actions]),P2,Table,Bag):- 
	%p1 check is overbodig want anders zou create row niet lukken -> enkel p2 checken
	\+ won_player(p2),
	create_crow(Blocks,NewRow,RemainingBlocks),
	Act=playrow(NewRow),
	play_game(P2,p1,(RemainingBlocks,Actions),[NewRow|Table],Bag).

%play nr Row
playgame(p1(Blocks,[Act|Actions]),P2,Table,Bag):-  
	%p1 check is overbodig want anders zou create row niet lukken -> enkel p2 checken
	\+ won_player(p2),
	create_,nrow(Blocks,NewRow,RemainingBlocks),
	Act=playrow(NewRow),
	play_game(P2,p1,(RemainingBlocks,Actions),[NewRow|Table],Bag).

%extend a row
playgame(p1(Blocks,[Act|Actions]),P2,Table,Bag):-
	%p1 check is overbodig want anders zou create row niet lukken -> enkel p2 checken
	\+ won_player(p2),
	select(Row,Tabel,RemainingTable),% will also remove the row
	extend_row(Row,Blocks,NewRow,RemainingBlocks,ExtendBlock),
	Act=playblock(NewRow,ExtendBlock),
	play_game(P2,p1,(RemainingBlocks,Actions),[NewRow|Table],Bag).

%draw card, can only be done when this is the only action possible
playgame(p1(Blocks,[Act|Actions]),P2,Table,[Block|RemainingBag]):- 
	\+ won_player(player(Blocks,[Act|Actions])),
	\+ won_player(p2),
	\+ create_crow(Blocks,_,_),
	\+ create_nrow(Blocks,_,_),
	\+ (member(OlrRow,Table),extend_row(OldRow,Blocks,_,_,_)),
	Act=draw(Block),
	play_game(P2,p1,([Block|Blocks],Actions),Table,RemainingBag).

%P1 win game
playgame(p1([],[win]),P2([_|_],[lose]),_,_). 

%P2 loses game
playgame(p1([_|_],[lose]),P2([],[win]),_,_).
%both playes win -> draw
playgame(p1([],[draw]),P2([],[draw]),_,_).

% draw when no actions can be taken and bag is empty 
playgame(p1(Blocks1,[draw]),p2(Blocks2,[draw]),Table,[]):-
	\+ won_player(player(Blocks1,_)),
	\+ won_player(player(Blocks2,_)),
	\+ create_crow(Blocks,_,_),
	\+ create_nrow(Blocks,_,_),
	\+ (member(OlrRow,Table),extend_row(OldRow,Blocks,_,_,_)),


%create random row,(order is importent, to not return a permutation of the same row) check row
create_crow(Allblocks,crow(NewRow),RemainingBlocks):-
	findall(SortedRow-Rem3,
		select(Block1,Allblocks,Rem1),
		select(Block2,Rem1,Rem2),
		select(Block2,Rem2,Rem3),
		sort([Block1,Block2,Block3],Sorted),
		\+ (invalid_crow(crow(Sorted))).
		Options
		),	
	list_to_set(Options,Nodups),%remove duplicates
	memeber(NewRow-RemainingBlocks,Nodups).
	


create_nrow(Allblocks,nrow(NewRoc),RemainingBlocks):
	findall(SortedRow-Rem3,
		select(Block1,Allblocks,Rem1),
		select(Block2,Rem1,Rem2),
		select(Block2,Rem2,Rem3),
		sort([Block1,Block2,Block3],Sorted),
		\+ (invalid_nrow(nrow(Sorted))).
		Options
		),	
	list_to_set(Options,Nodups),%remove duplicates
	memeber(NewRow-RemainingBlocks,Nodups).



%extend at start or end
extend_row(nrow(OldRow),Allblocks,nrow(NewRow),RemainingBlocks,ExtendBlock):
	select(ExtendBlock,Allblocks,RemainingBlocks),
	%append from back
	(
		append(Row,[ExtendBlock],NewRow)
	;
		append([ExtendBlock],Row,NewRow)
	)
	\+ (Invalid_nrow(NewRow)).
	

%needs resort
extend_row(crow(OldRow),Allblocks,crow(NewRow),RemainingBlocks,ExtendBlock):-
	select(ExtendBlock,Allblocks,RemainingBlocks),
	sort([ExtendBlock|OldRow],NewRow),
	\+ (Invalid_crow(NewRow)).

%check if play has won
won(p([],_)).



count_win(P1Blocks,P2Blocks,Bag,Res):- 
	findall(P1Act-P2Act,play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],Bag),AllActions),
	findall(P1Act, (memeber(P1Action-_,AllActions),won(P1Action),P1WonList),
	count(AllActions,Total),
	count(P1wonList,P1wins),
	Res is P1Wins/Total. 


won_game(P1Actions):-
	last(P1Actions,win).



count_win(P1Blocks,P2Blocks,Bag,Res):-
	play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2),[],Bag),
	select(win,Actions1,_W),
	find_all(W,(select(win,Actions1,W),play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2)),[],Bag),WinList),
	find_all(W,(+\(select(win,Actions1,W)),play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2)),[],Bag),NotWinList),
	length(WinList,Len),
	length(NotWinList,NoLen),
	Res is (NoLen+Len)/Len.
