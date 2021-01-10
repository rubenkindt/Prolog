valid_table([]).
valid_table(Table) :-
  select(Row,Table,RemTable),
  check_row(Row),
  valid_table(RemTable).

check_row(crow(Blocks)):-
  length(Blocks,Len),
  Len>=3,
  select(block(Nr,Color),Blocks,RemBlocks),
  checkDiffColor(RemBlocks,Nr,[Color]).
  
check_row(nrow(Blocks)):-
  length(Blocks,Len),
  Len>=3,
  select(block(Nr,Color),Blocks,RemBlocks),
  checkSeqNr(RemBlocks,Color,Nr).
  
checkDiffColor([],_,_).
checkDiffColor(Blocks,Nr,SeenColors):-
  select(block(Nr,Color),Blocks,RemBlocks),
  \+member(Color,SeenColors),
  checkDiffColor(RemBlocks,Nr,[Color|SeenColors]).
  
checkSeqNr([],_,_).
checkSeqNr(Blocks,Color,PrevNr):-
  select(block(Nr,Color),Blocks,RemBlocks),
  PrevNr =:= Nr - 1,
  checkSeqNr(RemBlocks,Color,Nr).
 
 
%%%%%%%%%%%%%%%%%%%
play_game(player([],[win]),player([_|_],[lose]),_Table,_Bag).
play_game(player([_|_],[lose]),player([],[win]),_Table,_Bag).
play_game(player([],[draw]),player([],[draw]),_Table,_Bag).

%play full crow
play_game(P1,P2,Table,Bag):- 
  play_crow(P1,P2,Table,Bag).  

%play full nrow
play_game(P1,P2,Table,Bag):- 
  play_nrow(P1,P2,Table,Bag). 
  
%append Crow
play_game(P1,P2,Table,Bag):- 
  append_crow(P1,P2,Table,Bag). 

%append Nrow
play_game(P1,P2,Table,Bag):- 
  append_nrow(P1,P2,Table,Bag).
  
%draw  
play_game(P1,P2,Table,Bag):-
  \+play_crow(P1,P2,Table,Bag),  
  \+play_nrow(P1,P2,Table,Bag), 
  \+append_crow(P1,P2,Table,Bag), 
  \+append_nrow(P1,P2,Table,Bag),
  draw_block(P1,P2,Table,Bag).

play_game(player([_|_],[draw]),player([_|_],[draw]),_Table,[]).

  
play_crow(player(PlayerBlocks,[playrow(crow(Sorted))|Actions]),P2,Table,Bag):-
  select(Block1,PlayerBlocks,RemPlayerBlocks1),
  select(Block2,RemPlayerBlocks1,RemPlayerBlocks2),
  select(Block3,RemPlayerBlocks2,RemPlayerBlocks3),
  sort([Block1,Block2,Block3],Sorted),
  check_row(crow(Sorted)),
  play_game(P2,player(RemPlayerBlocks3,Actions),[crow(Sorted)|Table],Bag).
  
play_nrow(player(PlayerBlocks,[playrow(nrow(Sorted))|Actions]),P2,Table,Bag):- 
  select(Block1,PlayerBlocks,RemPlayerBlocks1),
  select(Block2,RemPlayerBlocks1,RemPlayerBlocks2),
  select(Block3,RemPlayerBlocks2,RemPlayerBlocks3),
  sort([Block1,Block2,Block3],Sorted),
  check_row(nrow(Sorted)),
  play_game(P2,player(RemPlayerBlocks3,Actions),[nrow(Sorted)|Table],Bag).

append_crow(player(PlayerBlocks,[playblock(Block,NewRow)|Actions]),P2,Table,Bag):- 
  select(crow(Blocks),Table,RemTable),
  select(Block,PlayerBlocks,RemPlayerBlocks),
  sort([Block|Blocks],Sorted),
  check_row(crow(Sorted)),
  NewRow=crow(Sorted),
  play_game(P2,player(RemPlayerBlocks,Actions),[NewRow|RemTable],Bag).

append_nrow(player(PlayerBlocks,[playblock(Block,NewRow)|Actions]),P2,Table,Bag):- 
  select(nrow(Blocks),Table,RemTable),
  select(Block,PlayerBlocks,RemPlayerBlocks),
  sort([Block|Blocks],Sorted),
  check_row(nrow(Sorted)),
  NewRow=nrow(Sorted),
  play_game(P2,player(RemPlayerBlocks,Actions),[NewRow|RemTable],Bag).

draw_block(player(PlayerBlocks,[draw(Block)|Actions]),P2,Table,Bag):- 
  select(Block,Bag,RemBag),
  play_game(P2,player([Block|PlayerBlocks],Actions),Table,RemBag).


%%%%%%%%%%%%%
count_wins(B1,B2,Bag,WinPersentage):- 
  findall(A1,play_game(player(B1,A1),player(B2,_A2),[],Bag),Actions1),
  findall(win,member(win,Actions1),Wins),
  length(Wins,AantalWins),

  findall(notWin,\+member(win,Actions1),NoWins),  
  length(NoWins,AantalNoWins),
  
  WinPersentage is (AantalWins/(AantalNoWins+AantalWins)).






























 
