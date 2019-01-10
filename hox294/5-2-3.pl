% Person is male
male(philip).
male(charles).
male(william).
male(harry).
male(george).

% Person is female
female(elizabeth).
female(diana).
female(camilla).
female(catherina).
female(charlotte).

% Person1 is/was married to person2
married_to(elizabeth, philip).
married_to(philip, elizabeth).
married_to(diana, charles).
married_to(charles, diana).
married_to(charles, camilla).
married_to(camilla, charles).
married_to(william, catherine).
married_to(catherine, william).

% Person1 is a child of person2
child_of(charles, elizabeth).
child_of(charles, philip).
child_of(william, diana).
child_of(william, charles).
child_of(harry, diana).
child_of(harry, charles).
child_of(george, william).
child_of(george, catherine).
child_of(charlotte, william).
child_of(charlotte, catherine).

% problem3

aunt_of(Person1, Person2):-
female(Person1),
child_of(Person1, GP),
child_of(P, GP),
P \= Person1,
child_of(Person2,P).

grandchild_of(Person1, Person2):-
child_of(C, Person2),
child_of(Person1, C).

mother_of(Person1, Person2):-
female(Person1),
child_of(Person2, Person1).

stepmother_of(Person1, Person2):-
female(Person1),
child_of(Person2, C),
not(child_of(Person2, Person1)),
married_to(Person1, C).

nephew_of(Person1, Person2):-
male(Person1),
child_of(Person2, GP),
child_of(P, GP),
P \= Person2,
child_of(Person1, P).

mother_in_law_of(Person1, Person2):-
female(Person1),
married_to(Person2, WF),
mother_of(Person1, WF).

brother_in_law_of(Person1, Person2):-
male(Person1),
child_of(Person1, P),
child_of(B, P),
B \= Person1,
married_to(Person2, B).

ancestor_of(Person1, Person2):-
child_of(Person2, Person1);
child_of(Person2, P),
ancestor_of(Person1, P).
