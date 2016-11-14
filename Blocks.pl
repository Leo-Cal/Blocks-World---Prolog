

%Defines if X is member of list L

member(X, [X|Tail]).
member(X, [Head|Tail]) :-
	member(X, Tail).

%Deletes X from list

del(X, [X|L1] , L1).
del(X, [Head|L] , [Head|L1]) :-
	member(X,L),
	del(X,L,L1).

%Adds X to head of list

add(X,L, [X|L]).


%Actions


pickup(X) :-
	not(member(held(_), Ambient)),
	not(member(on(_,X), Ambient)),
        del( on(X,_), Ambient, Ambient1),
	add(held(X), Ambient1, Ambient2).

put_on_table(X) :-
	member(held(X), Ambient),
        del(held(X), Ambient, Ambient1),
	add(on(X,m), Ambient1, Ambient2).

putdown(X,Y) :-
	member(held(X), Ambient),
        del(held(X), Ambient, Ambient1),
	add(on(X,Y), Ambient1, Ambient2).
