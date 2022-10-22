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

%---------- OTROS PREDICADOS --------------------

% ---------------FLIPH ---------------------------------
	
pixelFlipH(Width,[[PosX,PosY],Color,Depth],[[NewPosX,PosY],Color,Depth]):-
	NewPosX is (Width - PosX - 1).

pixlistFlipH(_,[],[]).
pixlistFlipH(Width,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipH(Width,FirstPixel,NewPixel),
	pixlistFlipH(Width,RestPixels,RestPixels2).

imageFlipH(I, I2):- 
	image(Width,Height,PL1,I), 
	pixlistFlipH(Width,PL1,PL2), 
	image(Width,Height,PL2,I2).

% ------------------------ FLIPV -----------------

pixelFlipV(Height,[[PosX,PosY],Color,Depth],[[PosX,NewPosY],Color,Depth]):-
	NewPosY is (Height - PosY - 1).

pixlistFlipV(_,[],[]).
pixlistFlipV(Width,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipV(Width,FirstPixel,NewPixel),
	pixlistFlipV(Width,RestPixels,RestPixels2).

imageFlipV(Img1, Img2):- 
	image(Width,Height,Pixlist1,Img1), 
	pixlistFlipV(Width,Pixlist1,Pixlist2), 
	image(Width,Height,Pixlist2,Img2).

% ---------------------- CROP ----------------------

insideCrop(X1,Y1,X2,Y2,[[PosX,PosY],_,_]):-
	between(X1,X2,PosX),
	between(Y1,Y2,PosY).

filterCrop(X1,Y1,X2,Y2,L1,L2):-
	include(insideCrop(X1,Y1,X2,Y2),L1,L2).

pixlistCrop(_,_,_,_,[],[]).
pixlistCrop(X1,Y1,X2,Y2,Pixlist1,Pixlist2):-
	filterCrop(X1,Y1,X2,Y2,Pixlist1,Pixlist2).

newSize(X1,Y1,X2,Y2,NewWidth,NewHeight):-
	NewWidth is (X2 - X1 + 1),
	NewHeight is (Y2 - Y1 + 1).

imageCrop(Img1, X1, Y1, X2, Y2, Img2):-
	image(_,_,Pixlist1,Img1),
	pixlistCrop(X1,Y1,X2,Y2,Pixlist1,Pixlist2),
	newSize(X1,Y1,X2,Y2,NewWidth,NewHeight),
	image(NewWidth,NewHeight,Pixlist2,Img2).