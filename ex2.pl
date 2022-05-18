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

bool(true).
bool(false).

check(Premise1, Premise2, Conclusion) :- 
    (
    Premise1, Premise2, not(Conclusion) ->
    write('invalid') ;
    write('ok')
    ).


generateTable(P, Q, R, Premise1, Premise2, Conclusion) :-
    bool(P),
    bool(Q),
    bool(R),
    write(P),
    write('    \t'),
    write(Q),
    write('    \t'),
    write(R),
    write('    \t'),
    evaluate(Premise1, Result),
    write(Result),
    write('    \t'),
    evaluate(Premise2, ResultTwo),
    write(ResultTwo),
    write('    \t'),
    evaluate(Conclusion, ResultThree),
    write(ResultThree),
    write('    \t'),
    check(Premise1, Premise2, Conclusion),
    nl,
    fail.

table(P, Q, R, Premise1, Premise2, Conclusion) :-
    write('P'),
    write('           \t'),
    write('Q'),
    write('           \t'),
    write('R'),
    write('           \t'),
    write('Premise 1'),
    write('     \t'),
    write('Premise 2'),
    write('     \t'),
    write('Conclusion'),
    write('     \t'),
    write('Check?'),
    nl,
    generateTable(P, Q, R, Premise1, Premise2, Conclusion).