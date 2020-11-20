valid_table([]).
valid_table([crow(X)|Tail]):-
	validCrow(X),
	valid_table(Tail).

valid_table([nrow(X)|Tail]):-
	validNrow(X),
	valid_table(Tail).


validCrow(Blocks):-
	length(Blocks,Len),
	Len >=3,
	validCrow2(Blocks,[],_Nr).

validCrow2([],_UsedC,_Nr).
validCrow2([block(Nr,Color)|Tail],UsedC,Nr):-
	\+ member(Color,UsedC),
	validCrow2(Tail,[Color|UsedC],Nr).


validNrow(Blocks):-
	length(Blocks,Len),
	Len >=3,
	validNrow2(Blocks,_Nr,_Color).

validNrow2([],_UsedC,_Nr).
validNrow2([block(Nr,Color)|Tail],Nr,Color):-
	UsedNextNr is Nr + 1, 
	validNrow2(Tail,UsedNextNr,Color).







%playgame(P1(Blocks,Action),P2(Blocks,Action),Table,Bag)
playgame(p1([],draw),p2([],draw),_Table,_Bag).
playgame(p1([],win),p2(_Blocks2,lose),_Table,_Bag).
playgame(p1(_Blocks1,lose),p2([],win),_Table,_Bag).
playgame(p1(_Blocks1,draw),p2(_Blocks2,draw),_Table,[]).

play_game(P1,P2,Table,Bag):-
	playgame2(P1,P2,Table,Bag,1). % 1 = turn of person 1

%the xor of prolog didn't work like i wanted it
xor(false,true).
xor(true,false).

%player 1 turn
playgame2(p1(AllBlocks,[Action|Actions1]),P2,Table,Bag,1):-
	xor( 
		(
			addNrow(AllBlocks,NewAllblocks,Action,Nrow),
			playgame2(p1(NewAllblocks,Actions1),P2,[Nrow|Table],Bag,2)
		)
		;
		(
			addCrow(AllBlocks,NewAllblocks,Action,Crow),
			playgame2(p1(NewAllblocks,Actions1),P2,[Crow|Table],Bag,2)
		)
		;
		(
			playBlock(AllBlocks,NewAllblocks,Action,Table,NewTable),
			playgame2(p1(NewAllblocks,Actions1),P2,NewTable,Bag,2)
		)
	,
	
		(
			drawbag(NewBlock,Action,Bag,NewBag),
			playgame2(p1([NewBlock|NewAllblocks]),Actions1,P2,Table,NewBag,2)
		)
	).


%player 2 turn
playgame2(P1,p2(AllBlocks,[Action|Actions2]),Table,Bag,2):-
	xor(
		(
			addNrow(AllBlocks,NewAllblocks,Action,Nrow),
			playgame2(P1,p2(NewAllblocks,Actions2),[Nrow|Table],Bag,1)
		)
		;
		(
			addCrow(AllBlocks,NewAllblocks,Action,Crow),
			playgame2(P1,p2(NewAllblocks,Actions2),[Crow|Table],Bag,1)
		)
		;
		(
			playBlock(AllBlocks,NewAllblocks,Action,Table,NewTable),
			playgame2(P1,p2(NewAllblocks,Actions2),NewTable,Bag,1)
		)
	,
		(
			drawbag(NewBlock,Action,Bag,NewBag),
			playgame2(P1,p2([NewBlock|NewAllblocks]),Actions2,Table,NewBag,1)
		)
	).



drawBag(Block,draw(Block),[Block|RestBag],RestBag).


playBlock(AllBlocks,NewAllBlocks,Action,Table,NewTable):-
	playBlockToNrow(AllBlocks,NewAllBlocks,Action,Table,NewTable)
	;
	playBlockToCrow(AllBlocks,NewAllBlocks,Action,Table,NewTable).

playBlockToNrow(AllBlocks,NewAllBlocks,Action,Table,[nrow(Row)|TableWhRow]):-
	select(Block,AllBlocks,NewAllBlocks),
	select(nrow(Row),Table,TableWhRow),
	append(Block,nrow(Row),NewRow),
	sort(NewRow,SortedNewRow),
	validNrow(SortedNewRow),
	Action=playblock(Block,SortedNewRow).
	
playBlockToCrow(AllBlocks,NewAllBlocks,Action,Table,[crow(Row)|TableWhRow]):-
	select(Block,AllBlocks,NewAllBlocks),
	select(crow(Row),Table,TableWhRow),
	append(Block,crow(Row),NewRow),
	sort(NewRow,SortedNewRow),
	validNrow(SortedNewRow),
	Action=playblock(Block,SortedNewRow).


addNrow(Allblocks,NewAllblocks,Action1,Nrow):-
	length(Allblocks,Len),
	Len>3,
	select(Block1,Allblocks,AllblocksWh1),
	select(Block2,AllblocksWh1,AllblocksWh12),
	select(Block3,AllblocksWh12,NewAllblocks),
	sort((Block1,Block2,Block3),SortBlocks),
	validNrow(SortBlocks),
	Nrow=nrow(SortBlocks),
	Action1=playrow(Nrow).
	



addCrow(Allblocks,NewAllblocks,Action1,Crow):-
	length(Allblocks,Len),
	Len>3,
	select(Block1,Allblocks,AllblocksWh1),
	select(Block2,AllblocksWh1,AllblocksWh12),
	select(Block3,AllblocksWh12,NewAllblocks),
	sort((Block1,Block2,Block3),SortBlocks),
	validCrow(SortBlocks),
	Crow=crow(SortBlocks),
	Action1=playrow(Crow).



count_win(P1Blocks,P2Blocks,Bag,Res):-
	play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2),[],Bag),
	select(win,Actions1,_W),
	find_all(W,(select(win,Actions1,W),play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2)),[],Bag),WinList),
	find_all(W,(+\(select(win,Actions1,W)),play_game(p1(P1Blocks,Actions1),p2(P2Blocks,Actions2)),[],Bag),NotWinList),
	length(WinList,Len),
	length(NotWinList,NoLen),
	Res is (NoLen+Len)/Len.

