:-dynamic clear/1.
:-dynamic on/2.
:-dynamic held/1.



%Initial State
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
	clear(hand),
	clear(X),
      %effects
	assert(held(X)),
	retract(clear(X)),
	retract(clear(hand)).

putdown(X,A) :-
      %precond
	held(X),
	clear(A),
	A \== table,
	A \== X,
      %effects
        assert(clear(hand)),
	assert(on(X,A)),
	assert(clear(X)),
	retract(clear(A)),
	retract(held(X)).

