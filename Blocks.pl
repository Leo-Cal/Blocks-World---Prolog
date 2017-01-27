:-dynamic clear/1.
:-dynamic on/2.
:-dynamic held/1.
:-dynamic move/1.

block(a).
block(b).
block(c).
clear(hand).
clear(table).

%Initializer

init([]) :-
	true,
	init_clear([a,b,c]).


init([H|L]) :-
  initialize(H),
	init(L).

initialize(on(X,Y)) :-
	assert(on(X,Y)).


init_clear([]) :-
	true.

init_clear([H|L]) :-
	(initialize_clear(H); true),
	init_clear(L).

initialize_clear(X) :-
	not(on(_,X)),
	assert(clear(X)).


%Reset

reset :-
	retractall(on(_,_)),
	retractall(clear(_)),
	retractall(move(_)),
	assert(clear(table)),
	assert(clear(hand)).

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
	retract(on(X,_)),
	assert(move(pickup(X))).

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
	retract(held(X)),
	assert(move(putdown(X,A))).


put_on_table(X) :-
      %precond
	block(X),
	held(X),
      %effects
        assert(clear(hand)),
	assert(on(X,table)),
	assert(clear(X)),
	retract(held(X)),
	assert(move(put_on_table(X))).

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

solve([H|R],[G|L]) :-
  init([H|R]),
	fund_node([on(a,table),on(b,table),on(c,table)]),
	solve_level2([G|L]),
	solve_level3([G|L]).	

%Fund_node
   %Takes from the initial state to a state with all blocks on table

fund_node([]).

fund_node([H|L]) :-
		do(H),
		fund_node(L).

%solve_level2
   %Puts correct block on 2nd level of the pile

solve_level2([G|L]) :-
	 %find_level2([G|L]),
   %put_level2.

%solve_level3
	%Puts correct block (if there is one) on top level of the pile

solve_level3([G|L]) :-
	 %find_level3([G|L]),
	 %put_level3([G|L]).



%Doing

do(G) :-
	G.
do(on(A,B)):-
	force_putdown(A,B).
do(on(A,table)):-
	force_put_on_table(A).
