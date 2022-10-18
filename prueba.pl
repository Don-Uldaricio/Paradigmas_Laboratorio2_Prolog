pixbit(PosX, PosY, Bit, Depth, [[PosX, PosY], Bit, Depth]) :- 
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	integer(Bit), (Bit=0 ; Bit=1),
	integer(Depth), 0=<Depth.

pixrgb(PosX, PosY, R, G, B, Depth, [[PosX, PosY], [R, G, B], Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	integer(R), 0=<R, R=<255,
	integer(G), 0=<G, G=<255,
	integer(B), 0=<B, B=<255,
	integer(Depth), 0=<Depth.

pixhex(PosX, PosY, Hex, Depth, [[PosX, PosY], Hex, Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	string(Hex), string_length(Hex,7),
	integer(Depth), 0=<Depth.


% ---------------------------------------------------

image(Width, Height, Pixlist, [Width, Height, [], Pixlist, []]) :-
	integer(Width), 0=<Width,
	integer(Height), 0=<Height.

pixlistIsBit([]). 
pixlistIsBit([FirstPixel|RestPixels]):- 
	pixbit(_,_,_,_,FirstPixel),
	pixlistIsBit(RestPixels).

imageIsBitmap([_,_,_,Pixlist,_]):- 
	pixlistIsBit(Pixlist).

pixlistIsRGB([]). 
pixlistIsRGB([FirstPixel|RestPixels]):- 
	pixrgb(_,_,_,_,_,_,FirstPixel),
	pixlistIsRGB(RestPixels).

imageIsPixmap([_,_,_,Pixlist,_]):- 
	pixlistIsRGB(Pixlist).

pixlistIsHex([]). 
pixlistIsHex([FirstPixel|RestPixels]):- 
	pixhex(_,_,_,_,FirstPixel),
	pixlistIsHex(RestPixels).

imageIsHexmap([_,_,_,Pixlist,_]):- 
	pixlistIsHex(Pixlist).
