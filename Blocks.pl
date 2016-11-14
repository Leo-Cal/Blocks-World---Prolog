

%Defines if X is member of list L

member(X, [X|Tail]).
member(X, [Head|Tail]) :-
	member(X, Tail).




%Actions

pickup(X) :-
	not(member(held(_), Ambient)),
	not(member(on(_,X), Ambient)),
	remove&add( on(X,_), held(X), Ambient).

put_on_table(X) :-
	member(held(X), Ambient),
	remove&add(held(X) , on(X,m), Ambient).

