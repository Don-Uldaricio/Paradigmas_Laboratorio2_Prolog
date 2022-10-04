%image(Width, Height, )

pixbit-d(Posx, Posy, Bit, Depth, [[Posx, Posy], Bit, Depth]) :- 
	integer(Posx), 0=<Posx,
	integer(Posy), 0=<Posy,
	integer(Bit), (Bit=0 ; Bit=1),
	integer(Depth), 0=<Depth.

pixrgb-d(Posx, Posy, R, G, B, Depth, [[Posx, Posy], [R, G, B], Depth]) :-
	integer(Posx), 0=<Posx,
	integer(Posy), 0=<Posy,
	integer(R), 0=<R, R=<255,
	integer(G), 0=<G, G=<255,
	integer(B), 0=<B, B=<255,
	integer(Depth), 0=<Depth.

pixhex-d(Posx, Posy, Hex, Depth, [[Posx, Posy], Hex, Depth]) :-
	integer(Posx), 0=<Posx,
	integer(Posy), 0=<Posy,
	string(Hex),
	integer(Depth), 0=<Depth.

getColor(P, Color) :- nth0(1, P, Color).



% ---------------------------------------------------


image(Width, Height, L, [Width, Height, [], L, []]) :-
	integer(Width), 0=<Width,
	integer(Height), 0=<Height.

