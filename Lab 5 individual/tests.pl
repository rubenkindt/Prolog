:- include('solution.pl').

:- begin_tests(rummikub).

%------------------------------------------------------------------------------
% Test exercise 1

test(ex1_1) :-
    valid_table([ crow( [block(5,red) , block(5,yellow) , block(5,black)] ), nrow( [block(5,blue) , block(6,blue) , block(7,blue) , block(8,blue)] ) ]).

test(ex1_2) :-
    \+ valid_table([ crow( [block(5,red) , block(5,yellow)] ) ]).

test(ex1_3) :-
    \+ valid_table([ crow( [block(5,red) , block(5,yellow) , block(4,blue)] ) ]).

test(ex1_4) :-
    \+ valid_table([ nrow( [block(2,blue) , block(3,blue) , block(4,blue) , block(5,red)] ) ]).

test(ex1_5) :-
    \+ valid_table([ nrow( [block(5,blue) , block(6,blue) , block(8,blue)] ) ]).

test(ex1_6) :-
    \+ valid_table([ nrow( [block(5,blue) , block(7,blue) , block(6,blue)] ) ]).

%------------------------------------------------------------------------------
% Test exercise 2

    % Table 1 : example 1
test(ex2a_1) :-
    P1Blocks = [block(4,red),block(4,blue),block(4,black)],
    P2Blocks = [block(9,yellow)],
    Bag = [block(10,yellow)],
    Action = playrow(crow([block(4,black),block(4,blue),block(4,red)])),
    play_game(player(P1Blocks,[Action,win]),player(P2Blocks,[lose]),[],Bag), !.

% Table 1 : example 2
test(ex2a_2) :-
    P1Blocks = [block(4,red),block(5,red),block(6,red)],
    P2Blocks = [block(9,yellow)],
    Bag = [block(10,yellow)],
    Action = playrow(nrow([block(4,red),block(5,red),block(6,red)])),
    play_game(player(P1Blocks,[Action,win]),player(P2Blocks,[lose]),[],Bag), !.

% Table 1 : example 3
test(ex2a_3) :-
    P1Blocks = [block(7,red)],
    P2Blocks = [block(9,yellow)],
    Table = [nrow([block(4,red),block(5,red),block(6,red)])],
    Bag = [block(10,yellow)],
    Action = playblock(block(7,red), nrow([block(4,red),block(5,red),block(6,red),block(7,red)])),
    play_game(player(P1Blocks,[Action,win]),player(P2Blocks,[lose]),Table,Bag), !.

% Table 1 : example 4
test(ex2a_4) :-
    P1Blocks = [block(3,red)],
    P2Blocks = [block(9,yellow)],
    Table = [nrow([block(4,red),block(5,red),block(6,red)])],
    Bag = [block(10,yellow)],
    Action = playblock(block(3,red), nrow([block(3,red),block(4,red),block(5,red),block(6,red)])),
    play_game(player(P1Blocks,[Action,win]),player(P2Blocks,[lose]),Table,Bag), !.

% Table 1 : example 5
test(ex2a_5) :-
    P1Blocks = [block(4,red)],
    P2Blocks = [block(9,yellow)],
    Table = [crow([block(4,black),block(4,blue),block(4,yellow)])],
    Bag = [block(10,yellow)],
    Action = playblock(block(4,red), crow([block(4,black),block(4,blue),block(4,red),block(4,yellow)])),
    play_game(player(P1Blocks,[Action,win]),player(P2Blocks,[lose]),Table,Bag), !.

test(ex2_1) :-
    P1Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    P2Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    findall((P1Act,P2Act),(play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(5,blue)])),Sols),
    length(Sols,3).

test(ex2_2) :-
    P1Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    P2Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    P1Act = [ playrow(nrow([block(1, red), block(2, red), block(3, red)]))
              , draw(block(5, blue))
              , draw],
    P2Act = [ playblock(block(4, red), 
                        nrow([block(1, red), block(2, red), block(3, red), block(4, red)]))
              , playblock(block(5, red), 
                          nrow([block(1, red), block(2, red), block(3, red), block(4, red), block(5, red)]))
              , draw],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(5,blue)]), !.

test(ex2_3) :-
    P1Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    P2Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    P1Act = [ playrow(nrow([block(1, red), block(2, red), block(3, red)]))
              , draw(block(5, blue))
              , lose],
    P2Act = [ playblock(block(4, red), 
                        nrow([block(1, red), block(2, red), block(3, red), block(4, red)]))
              , playrow(crow([block(5, black), block(5, red), block(5, yellow)]))
              , win],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(5,blue)]), !.

test(ex2_4) :-
    P1Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    P2Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    P1Act = [ playrow(nrow([block(1, red), block(2, red), block(3, red)]))
              , draw(block(5, blue))
              , lose],
    P2Act = [ playrow(crow([block(5, black), block(5, red), block(5, yellow)]))
              , playblock(block(4, red), 
                          nrow([block(1, red), block(2, red), block(3, red), block(4, red)]))
              , win],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(5,blue)]), !.

test(ex2_5) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    findall((P1Act,P2Act),(play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)])),Sols),
    length(Sols,5).

test(ex2_6) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    P1Act = [ playrow(crow([block(2, black), block(2, blue), block(2, red)]))
              , draw(block(8, red))
              , playblock(block(8, red), 
                          nrow([block(5, red), block(6, red), block(7, red), block(8, red)]))
              , playblock(block(4, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red), block(8, red)]))
              , playblock(block(3, red),
                          nrow([block(3, red), block(4, red), block(5, red), block(6, red), block(7, red), 
                                block(8, red), block(9, red)]))
              , win],
    P2Act = [ draw(block(7, red))
              , playrow(nrow([block(5, red), block(6, red), block(7, red)]))
              , draw(block(9, red))
              , playblock(block(9, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red), block(8, red), 
                                block(9, red)]))
              , lose],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)]), !.

test(ex2_7) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    P1Act = [ playrow(crow([block(2, black), block(2, blue), block(2, red)]))
              , draw(block(8, red))
              , playblock(block(4, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red)]))
              , playblock(block(8, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red), block(8, red)]))
              , playblock(block(3, red),
                          nrow([block(3, red), block(4, red), block(5, red), block(6, red), block(7, red), 
                                block(8, red), block(9, red)]))
              , win],
    P2Act = [ draw(block(7, red))
              , playrow(nrow([block(5, red), block(6, red), block(7, red)]))
              , draw(block(9, red))
              , playblock(block(9, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red), block(8, red), 
                                block(9, red)]))
              , lose],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)]), !.

test(ex2_8) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    P1Act = [ playrow(crow([block(2, black), block(2, blue), block(2, red)]))
              , draw(block(8, red))
              , playblock(block(4, red),
                          nrow([block(4, red), block(5, red), block(6, red), block(7, red)]))
              , playblock(block(3, red),
                          nrow([block(3, red), block(4, red), block(5, red), block(6, red), block(7, red)]))
              , draw],
    P2Act = [ draw(block(7, red))
              , playrow(nrow([block(5, red), block(6, red), block(7, red)]))
              , draw(block(9, red))
              , draw],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)]), !.

test(ex2_9) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    P1Act = [ playrow(nrow([block(2, red), block(3, red), block(4, red)]))
              , draw(block(7, red))
              , playblock(block(7, red), 
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red), 
                                block(7, red)]))
              , draw(block(9, red))
              , playblock(block(9, red),
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red), 
                                block(7, red), block(8, red), block(9, red)]))
              , draw],
    P2Act = [ playblock(block(5, red), 
                        nrow([block(2, red), block(3, red), block(4, red), block(5, red)]))
              , playblock(block(6, red),
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red)]))
              , draw(block(8, red))
              , playblock(block(8, red),
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red), 
                                block(7, red), block(8, red)]))
              , draw],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)]), !.

test(ex2_10) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    P1Act = [ playrow(nrow([block(2, red), block(3, red), block(4, red)]))
              , draw(block(7, red))
              , playblock(block(7, red),
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red), 
                                block(7, red)]))
              , draw(block(9, red))
              , lose],
    P2Act = [ playblock(block(5, red),
                        nrow([block(2, red), block(3, red), block(4, red), block(5, red)]))
              , playblock(block(6, red), 
                          nrow([block(2, red), block(3, red), block(4, red), block(5, red), block(6, red)]))
              , draw(block(8, red))
              , playrow(crow([block(8, black), block(8, blue), block(8, red)]))
              , win],
    play_game(player(P1Blocks,P1Act),player(P2Blocks,P2Act),[],[block(7,red),block(8,red),block(9,red)]), !.


%------------------------------------------------------------------------------
% Test exercise 3

test(ex3_1) :-
    P1Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    P2Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    count_wins(P1Blocks,P2Blocks,[block(5,blue)],0).

test(ex3_2) :-
    P1Blocks = [block(5,red),block(5,yellow),block(5,black),block(4,red)],
    P2Blocks = [block(1,red),block(2,red),block(3,red),block(2,blue)],
    count_wins(P1Blocks,P2Blocks,[block(5,blue)],1).

test(ex3_3) :-
    P1Blocks = [block(2,red),block(3,red),block(4,red),block(2,blue),block(2,black)],
    P2Blocks = [block(5,red),block(6,red),block(8,blue),block(8,black)],
    count_wins(P1Blocks,P2Blocks,[block(7,red),block(8,red),block(9,red)],0.4).

:- end_tests(rummikub).
	    
:- run_tests.

:- halt.
