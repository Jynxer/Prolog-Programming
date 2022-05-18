and(P,Q):- P, Q.

my_not(P) :- call(P), !, fail.
my_not(P).

t.
f :- fail.

or(P, Q) :- my_not(and(my_not(P), my_not(Q))).
not(P) :- my_not(P).
implies(P, Q) :- or(not(P), Q).

evaluate(X, true) :- X, !.
evaluate(_, false).

node(n1, 'and(').
node(n2, 'not(').
node(n3, 'or(').
node(n4, 'r').
node(n5, 'q').
node(n6, 'p').

:-dynamic(branch/3).

branch(n1, n3, n2).
branch(n2, n6, void).
branch(n3, n4, n5).
branch(n4, void, void).
branch(n5, void, void).
branch(n6, void, void).

hasLeft(NodeId) :- branch(NodeId, Child, _), Child \= void.
hasRight(NodeId) :- branch(NodeId, _, Child), Child \= void.

isLeaf(NodeId) :- hasLeft(NodeId), hasRight(NodeId).

printTree(_NodeId) :-
    node(_NodeId, X),
    branch(_NodeId, Left, Right),
    write(X),
    (hasLeft(_NodeId), hasRight(_NodeId) -> printTree(Left), write(','); t),
    (hasLeft(_NodeId), not(hasRight(_NodeId)) -> printTree(Left), write(')'); t),
    (hasRight(_NodeId) -> printTree(Right), write(')') ; t).

and-commutativity(_NodeId) :-
    node(_NodeId, 'and('),
    retract(branch(_NodeId, X, Y)),
    asserta(branch(_NodeId, Y, X)).

first-de-morgan(_NodeId) :-
    node(_NodeId, 'not('),
    branch(_NodeId, OrNode, void),
    node(OrNode, 'or('),
    retract(node(_NodeId, _)),
    retract(node(OrNode, _)),
    retract(branch(_NodeId, _, _)),
    retract(branch(OrNode, Left, Right)),
    asserta(node(_NodeId, 'or(')),
    asserta(node(OrNode, 'not(')),
    asserta(node(new, 'not(')),
    asserta(branch(_NodeId, OrNode, new)),
    asserta(branch(OrNode, Left, void)),
    asserta(branch(new, Right, void)).

or-associativity(_NodeId) :-
    node(_NodeId, 'or('),
    retract(branch(_NodeId, LeftOne, RightOne)),
    retract(branch(LeftOne, LeftTwo, RightTwo)),
    asserta(branch(_NodeId, LeftTwo, LeftOne)),
    asserta(branch(LeftOne, RightTwo, RightOne)).