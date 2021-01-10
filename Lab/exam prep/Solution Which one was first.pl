
% exercise 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the goal predicate
color_rectangle(Board, ColorRectangleList) :- 
    colorset_on_board(Board, ColorSet),
    board_indexes(Board, RowIndexes, ColIndexes),
    color_positions(Board, RowIndexes, ColIndexes, ColorSet, ColorPositions),
    findall(Color-rhk(MinCol, MaxCol, MinRow, MaxRow),
        (
            member(Color-ColorRowList-ColorColumnList, ColorPositions),
            min_list(ColorRowList, MinRow),
            max_list(ColorRowList, MaxRow),
            min_list(ColorColumnList, MinCol),
            max_list(ColorColumnList, MaxCol)
        ),
        ColorRectangleListUnsorted),
    sort(ColorRectangleListUnsorted, ColorRectangleList).

% Get for each color the row and column indexes for which it occurs.
% color_positions(Board, RowIndexes, ColIndexes, ColorSet, ColorPositions)
color_positions(_Board, _RowIndexes, _ColIndexes, [], []). % all colors done
color_positions(Board, RowIndexes, ColIndexes, [Color|ColorRest], [Color-RowList-ColumnList|ColorPositionsRest]) :-
    findall(RowIndex,
        (
            % generate all board positions
            member(RowIndex, RowIndexes), member(ColIndex, ColIndexes),
            nth1(RowIndex, Board, Row), nth1(ColIndex, Row, Elem),
            Elem = Color
        ),
        RowList),
    findall(ColIndex,
        (
            % generate all board positions
            member(RowIndex, RowIndexes), member(ColIndex, ColIndexes),
            nth1(RowIndex, Board, Row), nth1(ColIndex, Row, Elem),
            Elem = Color
            ), ColumnList),
    color_positions(Board, RowIndexes, ColIndexes, ColorRest, ColorPositionsRest).

% Set of colors on the board
colorset_on_board(BoardListOfLists, ColorSet) :-
    flatten(BoardListOfLists,BoardFlattened),
    delete(BoardFlattened,'.',BoardFlattenedFiltered),
    list_to_set(BoardFlattenedFiltered,ColorSet).

/*
For a MxM board, 
    RowIndexes = [1,2,...,M]
ColIndexes = [1,2,...,N]
*/
board_indexes(Board, RowIndexes, ColIndexes) :-
    [Row1|_] = Board,
    length(Board, NbOfRows),
    length(Row1, NbOfCols),
    numlist(1, NbOfRows, RowIndexes),
    numlist(1, NbOfCols, ColIndexes).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exercise 2: sequence(Board, Order)

/*
Find the order in which the cards where layed out on the board.
e.g.
    R = [b,b,b,6,6,6],
        [.,5,5,5,x,5],
        [a,5,5,c,c,5],
        [a,5,5,c,c,5],
        [a,6,6,6,6,6]]
    O = [6, 5, a, b, c, x]
*/
sequence(Board, Order) :-
    color_rectangle(Board, ColorRectangleList),
    find_order(ColorRectangleList, [], Board, Order).

find_order([],_,_,[]):-!.
find_order(ColorRectangleList, RemovedColors, Board, ColorOrder):-
    % find the cards on top
    findall(RemainingCard,
        (
            member(RemainingCard, ColorRectangleList),
            upper(RemainingCard, RemovedColors, Board)
            ),
        UpperCards),
    % remove the upper cards from the cards that we still need to inspect
    subtract(ColorRectangleList, UpperCards, RemainingCards),
    % make a list containing only the colors, without the rhk()-suffix
    findall(Color,
        member(Color-_, UpperCards),
        UpperCardColors),
    % add the upper colors to the list of removed colors
    append(RemovedColors, UpperCardColors, NewRemovedColors),
    % recurse
    find_order(RemainingCards, NewRemovedColors, Board, ColorOrderRemainingCards),
    % sort the colors of the upper cards
    sort(UpperCardColors, UpperCardColorsSorted),
    % the upper colors where layed out AFTER the colors from the recursive step
    append(ColorOrderRemainingCards, UpperCardColorsSorted, ColorOrder).

/*
Succeeds if the given card is an upper card on the Board.

1. Collects all cells covered by the card
2. Checks whether theses cells only contain 
        the cards color or an already removed color
*/
upper(Color-rhk(MinCol, MaxCol, MinRow, MaxRow), AlreadyRemovedColors, Board) :-
    numlist(MinCol, MaxCol, ColIndexes),
    numlist(MinRow, MaxRow, RowIndexes),
    findall(CardCell,
        (
            member(ColIndex, ColIndexes), member(RowIndex, RowIndexes),
            nth1(RowIndex, Board, Row), nth1(ColIndex, Row, CardCell)
        ),
        CardCells
    ),
    /*
    To be an upper card, the card can only contain its own color and already removed colors.
    --> the list of colors after substracting the allowed colors must be empty.
    */
    AllowedColors = [Color|AlreadyRemovedColors],
    subtract(CardCells, AllowedColors, []).

