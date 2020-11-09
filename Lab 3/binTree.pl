%Tree := nil|t(Tree,Value,Tree).

diffMax1(X,X).
diffMax1(X,Y):-
   Diff is X - Y,
   (
   	Diff == -1
   	;
   	Diff == 0
   	;
   	Diff == 1
   	).

balanced(nil).
balanced(Tree):- balanced2(Tree,_X).

balanced2(nil,0).
balanced2(t(LTree,_Value,RTree),Depth):-
   
   balanced2(LTree,LDepth),
   balanced2(RTree,RDepth),
   %write("left"),write(LDepth),nl,
   %write("right"),write(RDepth),nl,
   diffMax1(LDepth,RDepth),
   Depth is max(LDepth,RDepth) + 1.


add_to(nil,Value,t(nil,Value,nil)).

%left part
add_to(t(InL,Value,InR),NewValue,OutTree):-
  balanced2(InL,LDepth),
  balanced2(InR,RDepth),
  LDepth < RDepth,
  add_to(InL,NewValue,OutL), 
  OutTree = t(OutL,Value,InR).

%right part
add_to(t(InL,Value,InR),NewValue,OutTree):-
  balanced2(InL,LDepth),
  balanced2(InR,RDepth),
  LDepth >= RDepth,
  add_to(InR,NewValue,OutR),
  OutTree = t(InL,Value,OutR).


alpha_beta(leaf(Score,_Value),Alpha,Beta,Score,NewTree):-
  Beta =< Alpha,
  NewTree = nil.

alpha_beta(leaf(Score,Value),_Alpha,_Beta,Score,NewTree):-
  NewTree = leaf(Score,Value).

alpha_beta(max(L,R),Alpha,Beta,Score,NewTree):-
  alpha_beta(L,Alpha,Beta,LScore,LNewTree),
  alpha_beta(R,Alpha,Beta,RScore,RNewTree),
  Score is max(LScore,RScore),
  Alpha = Score,
  NewTree = max(LNewTree,RNewTree).

alpha_beta(min(L,R),Alpha,Beta,Score,NewTree):-
  alpha_beta(L,Alpha,Beta,LScore,LNewTree),
  alpha_beta(R,Alpha,Beta,RScore,RNewTree),
  Score is min(LScore,RScore),
  Beta = Score,
  NewTree = min(LNewTree,RNewTree).

