parent(university, facultyOne).
parent(university, facultyTwo).

parent(facultyOne, schoolOne).
parent(facultyOne, schoolTwo).
parent(facultyTwo, schoolThree).
parent(facultyTwo, schoolFour).

parent(schoolOne, departmentOne).
parent(schoolOne, departmentTwo).
parent(schoolTwo, departmentThree).
parent(schoolTwo, departmentFour).
parent(schoolThree, departmentFive).
parent(schoolThree, departmentSix).
parent(schoolFour, departmentSeven).
parent(schoolFour, departmentEight).

parent(departmentOne, moduleOne).
parent(departmentOne, moduleTwo).
parent(departmentTwo, moduleThree).
parent(departmentTwo, moduleFour).
parent(departmentThree, moduleFive).
parent(departmentThree, moduleSix).
parent(departmentFour, moduleSeven).
parent(departmentFour, moduleEight).
parent(departmentFive, moduleNine).
parent(departmentFive, moduleTen).
parent(departmentSix, moduleEleven).
parent(departmentSix, moduleTwelve).
parent(departmentSeven, moduleThirteen).
parent(departmentSeven, moduleFourteen).
parent(departmentEight, moduleFifteen).
parent(departmentEight, moduleSixteen).

parent(departmentOne, moduleEleven).
parent(departmentOne, moduleTwelve).
parent(departmentTwo, moduleThirteen).
parent(departmentTwo, moduleFourteen).
parent(departmentThree, moduleFifteen).
parent(departmentThree, moduleSixteen).

student(alex).
student(brandon).
student(casey).
student(daniel).

studies(alex, moduleOne).
studies(alex, moduleFive).
studies(alex, moduleNine).
studies(alex, moduleThirteen).
studies(alex, moduleTwo).
studies(alex, moduleSix).
studies(alex, moduleTen).
studies(alex, moduleFourteen).
studies(brandon, moduleTwo).
studies(brandon, moduleSix).
studies(brandon, moduleTen).
studies(brandon, moduleFourteen).
studies(brandon, moduleThree).
studies(brandon, moduleSeven).
studies(brandon, moduleEleven).
studies(brandon, moduleFifteen).
studies(casey, moduleThree).
studies(casey, moduleSeven).
studies(casey, moduleEleven).
studies(casey, moduleFifteen).
studies(casey, moduleFour).
studies(casey, moduleEight).
studies(casey, moduleTwelve).
studies(casey, moduleSixteen).
studies(daniel, moduleFour).
studies(daniel, moduleEight).
studies(daniel, moduleTwelve).
studies(daniel, moduleSixteen).
studies(daniel, moduleOne).
studies(daniel, moduleFive).
studies(daniel, moduleNine).
studies(daniel, moduleThirteen).

collaborates(DepartmentA, DepartmentB, Module) :-
    parent(DepartmentA, Module),
    parent(DepartmentB, Module).

enrolled(Student) :- studies(Student, _).

unique(X, Y) :- X \= Y.

shareClasses(StudentOne, StudentTwo) :-
    unique(StudentOne, StudentTwo),
    studies(StudentOne, Module),
    studies(StudentTwo, Module).

schoolOffersModule(School, Module) :-
    parent(School, X),
    parent(X, Module).

showModulesSchoolOffers(School) :-
    schoolOffersModule(School, Module),
    nl,
    write(Module),
    nl.

belongsTo(X, Y) :- parent(Y, X).
belongsTo(X, Y) :- parent(Y, Z), belongsTo(X, Z).

memberOf(X, Y) :-
    studies(X, Y);
    parent(Y, Z), studies(X, Z);
    parent(Y, Z), parent(Z, A), studies(X, A);
    parent(Y, Z), parent(Z, A), parent(A, B), studies(X, B).