

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

%Pickups
action(Ambient,pickup_a,Ambient2) :-
	not(member(held(_), Ambient)),
	not(member(on(_,a), Ambient)),
        del( on(a,_), Ambient, Ambient1),
	add(held(a), Ambient1, Ambient2).

action(Ambient,pickup_b,Ambient2) :-
	not(member(held(_), Ambient)),
	not(member(on(_,b), Ambient)),
        del( on(b,_), Ambient, Ambient1),
	add(held(b), Ambient1, Ambient2).

action(Ambient,pickup_c,Ambient2) :-
	not(member(held(_), Ambient)),
	not(member(on(_,c), Ambient)),
        del( on(c,_), Ambient, Ambient1),
	add(held(c), Ambient1, Ambient2).

%Puts on Table
action(Ambient,put_a_on_table, Ambient2) :-
	member(held(a), Ambient),
        del(held(a), Ambient, Ambient1),
	add(on(a,m), Ambient1, Ambient2).

action(Ambient,put_b_on_table, Ambient2) :-
	member(held(b), Ambient),
        del(held(b), Ambient, Ambient1),
	add(on(b,m), Ambient1, Ambient2).

action(Ambient,put_c_on_table, Ambient2) :-
	member(held(c), Ambient),
        del(held(c), Ambient, Ambient1),
	add(on(c,m), Ambient1, Ambient2).

%Putdowns
action(Ambient,putdown_ab,Ambient2) :-
	member(held(a), Ambient),
        del(held(a), Ambient, Ambient1),
	add(on(a,b), Ambient1, Ambient2).

action(Ambient,putdown_ac,Ambient2) :-
	member(held(a), Ambient),
        del(held(a), Ambient, Ambient1),
	add(on(a,c), Ambient1, Ambient2).

action(Ambient,putdown_ba,Ambient2) :-
	member(held(b), Ambient),
        del(held(b), Ambient, Ambient1),
	add(on(b,a), Ambient1, Ambient2).

action(Ambient,putdown_bc,Ambient2) :-
	member(held(b), Ambient),
        del(held(b), Ambient, Ambient1),
	add(on(b,c), Ambient1, Ambient2).

action(Ambient,putdown_ca,Ambient2) :-
	member(held(c), Ambient),
        del(held(c), Ambient, Ambient1),
	add(on(c,a), Ambient1, Ambient2).

action(Ambient,putdown_cb,Ambient2) :-
	member(held(c), Ambient),
        del(held(c), Ambient, Ambient1),
	add(on(c,b), Ambient1, Ambient2).



%Solving

solve(Ambient1, Ambient1).
solve(Ambient1,Ambient2) :-
	action(Ambient1, Move, Intermediary),
	solve(Intermediary, Ambient2).


