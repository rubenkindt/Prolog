% Name: Kindt Ruben
% student number: R0656495
% programme of study: Master CW

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGNMENT 1 predicate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color_rectangle(R,Rect):- 
  get_all_colors(R,AllColors),
  color_rectangle_helper(R,AllColors,Rect).

color_rectangle_helper(_,[],[]).
color_rectangle_helper(R,AllColors,[Color-Rhk|Rect]):-
  select(Color,AllColors,RemColore),
  get_TL_and_BR(R,Color,TopL-BottemR),
  get_TR_and_BL(R,Color,TopR-BottemL),
  opp(R,TopL-BottemR,TopR-BottemL,VisibleCorners),
  corners_to_rhk(VisibleCorners,Rhk),
  color_rectangle_helper(R,RemColors,Rect).
  
  
corners_to_rhk((Col1,Row1)-(Col2-Row2),rhk(ColMin,ColMax,RowMin,RowMax)):-
  ColMin = min(Col1,Col2),
  ColMax = max(Col1,Col2),
  RowMin = min(Row1,Row2),
  RowMax = max(Row1,Row2).

  
%assumes square
maw_row([FirstRow|_R],MaxRow):- 
  length(FirstRow,MaxRow).
  
max_col(R,MaxRow):-
  length(R,MaxRow).
  
get_all_colors(R,Allcolors):-
  get_all_colors_helper(R,AllcolorsWithDubs),
  append(R,AllcolorsWithDubs),
  list_to_set(AllcolorsWithDubs,AllColors).
  
get_TL_and_BR(R,Color,TopL-BottemR):-
  get_TL(R,Color,1,1,TopL), %start searching in Row 1, col1
  myReverse(R,RevR),
  get_BR(RevR,Color,1,1,BottemR). %start searching in row_max,col_max
 
get_BR([FirstRow|R],Color,CurrentRow,CurrentCol,BottemR):-
  

get_TL([],_,_,_,_).
get_TL([FirstRow|R],Color,CurrentRow,CurrentCol,TopL):-
  get_TL_helper(FirstRow,Color,CurrentRow,CurrentCol,TopL),
  get_TL(R,Color,CurrentRow+1,1,TopL).
  
get_TL_helper([FirstElem|Row],Color,CurrentRow,CurrentCol,TopL):-
  FirstElem == Color 
  ->
    TopL=(CurrentCol-CurrentRow),!
  ;
    get_TL_helper(Row,Color,CurrentRow,CurrentCol+1,TopL).

get_TR_and_BL(R,Color):-

opp(R,(TLCol,TLRow)-(BRCol-BRRow),(TRCol-TRRow)-(BLCol-BLRow),VisibleCorners):-
  TLBRopp is ((TLCol-BRCol)+1)*((TLRow-BRRow)+1),
  TRBLopp is ((TRCol-BLCol)+1)*((TRRow-BLRow)+1),
  
  TLBRopp >= TRBLopp
  ->
    VisibleCorners = (TLCol,TLRow)-(BRCol-BRRow)
  ;
    VisibleCorners = (TRCol-TRRow)-(BLCol-BLRow).
  




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGNMENT 2 predicate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sequence(R,Seq):- 
  get_sequence(R,Seq).

get_sequence(R,[Color-Rhk|Seq]):-
  get_top_rect(R,Color-Rhk),
  overwrite(R,Color,NewColor,Rnew),
  get_sequence(Rnew,Seq).
  
overwrite([],_,[]):-
overwrite([FirstRow|R],Color,NewColor,[NewRow|Rnew]):-
  overWrite_row(FirstRow,Color,NewColor,NewRow),
  overwrite(R,Color,NewColor,Rnew).

overWrite_row([],_,_,[]).
overWrite_row([Elem|Row],Color,NewColor,[NewElem|NewRow]):-
  Elem=Color
  -> 
    NewElem=NewColor,
    overWrite_row(Row,Color,NewColor,NewRow)
  ;
    NewElem=Color,
    overWrite_row(Row,Color,NewColor,NewRow).
  


get_top_rect(R,TopRect):-
  get_all_colors(R,AllColors),
  get_top_rect_helper(R,AllColors,Rect).
  
get_top_rect_helper(R,AllColors,Rect):-
  select(Color,AllColors,RemColors),
  color_rectangle_helper(R,[Color],Rect),
  check_top(R,Rect,1,1).% search start at row 1 col 1

check_top([]],_,_,_).
check_top([FirstRow|R],CurrentRow,CurrentCol,Color-rhk(MinCol,MaxCol,MinRow,MaxRow)):-
  (
    MinRow =< CurrentRow, 
    CurrentRow =< MaxRow
  ), 
  -> 
    check_row(FirstRow,CurrentRow,CurrentCol,Color-rhk(MinCol,MaxCol,MinRow,MaxRow)),
    check_top(R,CurrentRow+1,CurrentCol,Color-rhk(MinCol,MaxCol,MinRow,MaxRow))
    ;
    
    check_top(R,CurrentRow+1,CurrentCol,Color-rhk(MinCol,MaxCol,MinRow,MaxRow)).
    
check_row([],_,_,_).    
check_row([Element|Row],CurrentRow,CurrentCol,Color-rhk(MinCol,MaxCol,MinRow,MaxRow)):-
  (
    MinCol =< CurrentCol, 
    CurrentCol =< MaxCol
  ), 
  -> 
     Element=Color,
     check_row(Row,CurrentRow,CurrentCol+1,Color-rhk(MinCol,MaxCol,MinRow,MaxRow)).
   ;
     true.





























