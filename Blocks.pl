:-dynamic clear/1.
:-dynamic on/2.
:-dynamic held/1.



%Initial State

block(a).
block(b).
block(c).
clear(hand).
on(a,table).
on(b,table).
on(c,table).
clear(a).
clear(b).
clear(c).
clear(table).

%Actions

pickup(X) :-
      %precond
	block(X),
	clear(hand),
	clear(X),
      %effects
	assert(held(X)),
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

%Solving

