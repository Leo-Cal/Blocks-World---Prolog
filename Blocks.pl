:-dynamic clear/1.
:-dynamic on/2.
:-dynamic held/1.



%Initial State

block(a).
block(b).
block(c).
on(a,table).
on(b,table).
on(c,b).
clear(a).

clear(c).
clear(table).
clear(hand).

%Basic Actions

pickup(X) :-
      %precond
	block(X),
	clear(hand),
	clear(X),
	on(X,K),
      %effects
	assert(held(X)),
	assert(clear(K)),
	retract(clear(X)),
	retract(clear(hand)),
	retract(on(X,_)).

putdown(X,A) :-
      %precond
	block(X),
	block(A),
	held(X),
	clear(A),
	A \== X,
      %effects
        assert(clear(hand)),
	assert(on(X,A)),
	assert(clear(X)),
	retract(clear(A)),
	retract(held(X)).

put_on_table(X) :-
      %precond
	block(X),
	held(X),
      %effects
        assert(clear(hand)),
	assert(on(X,table)),
	assert(clear(X)),
	retract(held(X)).

%Forced Actions
   %(these actions are designed to achieve a certain goal independent of the state on which they are called on).


force_put_on_table(A) :-
	on(A,table).

force_put_on_table(A):-
      %precond
	block(A),
	force_pickup(A),
      %effects
        put_on_table(A).


force_putdown(A,B):-
	on(A,B).

force_putdown(A,B) :-
      %precond
	block(A),
	block(B),
	force_clear(B),
	force_pickup(A),
      %effects
        putdown(A,B).

force_pickup(A) :-
	held(A).

force_pickup(A) :-
      %precond
	block(A),
	force_clear(A),
      %effects
        pickup(A).

force_clear(A):-
	clear(A).

force_clear(A) :-
      %precond
	on(X,A),
	force_put_on_table(X).
      %effects



%Solving

solve_all([G|L]) :-
	solve(G),
	solve_all(L).

solve(G) :-
	G.
solve(on(A,B)):-
	force_putdown(A,B).

