

%Defines if X is member of list L

member(X, [X|Tail]).
member(X, [Head|Tail]) :-
	member(X, Tail).

%Deletes X from list

del(X, [X|L1] , L1).
del(X, [Head|L] , [Head|L1]) :-
	member(X,L),
	del(X,L,L1).





%Actions

pickup(X) :-
	not(member(held(_), Ambient)),
	not(member(on(_,X), Ambient)),
	remove&add( on(X,_), held(X), Ambient).

put_on_table(X) :-
	member(held(X), Ambient),
	remove&add(held(X) , on(X,m), Ambient).

putdonw(X,Y) :-
	member(held(X), Ambient),
	remove&add(held(X), on(X,Y), Ambient).
