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

%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),pixbit(2,1,1,4,PF),image(3,2,[PA,PB,PC,PD,PE,PF],I1),imageCrop(I1,0,0,1,1,I2).
%pixrgb(0,0,1,45,200,10,PA),pixrgb(0,1,123,54,65,20,PB),pixlistRGBtoHex([PA,PB],L).

% ----------------------- RGB to HEX -----------------

pixlistRGBtoHex([],[]).
pixlistRGBtoHex([[[PosX,PosY],RGBColor,Depth]|RestPixels],[[[PosX,PosY],HexColor,Depth]|RestPixels2]):-
	hex_bytes(HexLowCase,RGBColor),
	string_upper(HexLowCase,HexUpperCase),
	string_concat("#",HexUpperCase,HexColor),
	pixlistRGBtoHex(RestPixels,RestPixels2).

imageRGBtoHex(I1,I2):-
	image(Width,Height,Pixlist1,I1),
	imageIsPixmap(I1),
	pixlistRGBtoHex(Pixlist1,Pixlist2),
	image(Width,Height,Pixlist2,I2),
	imageIsHexmap(I2).

% ------------- Histogram ---------------------

%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),pixbit(2,1,1,4,PF),imageColors([PA,PB,PC,PD,PE,PF],CL).
% colorFreq(0,[[[0,0],1,4],[[0,0],0,4],[[0,0],0,4],[[0,0],1,4],[[0,0],1,4],[[0,0],1,4]],CL).
% colorFreqList([0,1],[[[0,0],1,4],[[0,0],0,4],[[0,0],0,4],[[0,0],1,4],[[0,0],1,4],[[0,0],1,4]],CL).

imageColors([],[]).
imageColors([[_,Color,_]|RestPixels],[Color|RestColors]):-
	imageColors(RestPixels,RestColors).

removeDuplicatedColors([],[]).
removeDuplicatedColors([FirstColor|RestColors],ColorList):-
	member(FirstColor,RestColors), !,
	removeDuplicatedColors(RestColors,ColorList).
removeDuplicatedColors([FirstColor|RestColors],[FirstColor|ColorList]):-
	removeDuplicatedColors(RestColors,ColorList).

colorFreqList([],_,[]).
colorFreqList([FirstColor|RestColors],Pixlist,[ColorCount|RestColorCount]):-
	colorFreq(FirstColor,Pixlist,ColorCount),
	colorFreqList(RestColors,Pixlist,RestColorCount).

colorFreq(_,[],0).
colorFreq(Color,[[_,Color,_]|RestPixels],ColorCount):-
	!, colorFreq(Color,RestPixels,ColorCount2),
	ColorCount is (ColorCount2 + 1).
colorFreq(Color,[_|RestPixels],ColorCount):-
	colorFreq(Color, RestPixels, ColorCount).

histogram([],[],[]).
histogram([FirstColor|RestColors],[FirstFreq|RestFreq],[[FirstColor,FirstFreq]|RestElements]):-
	histogram(RestColors,RestFreq,RestElements).

imageToHistogram(Image, Histogram):-
	image(_,_,Pixlist,Image),
	imageColors(Pixlist,ImageColors),
	removeDuplicatedColors(ImageColors,ColorList),
	colorFreqList(ColorList,Pixlist,ColorFreqList),
	histogram(ColorList,ColorFreqList,Histogram).

%histogram([0,1],[2,4],F).
%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),pixbit(2,1,1,4,PF),image(1,1,[PA,PB,PC,PD,PE,PF],I),imageToHistogram(I,H).
%pixrgb(0,0,1,45,200,10,PA),pixrgb(0,1,123,54,65,20,PB),pixrgb(0,0,123,54,65,10,PC),pixrgb(0,1,12,14,20,20,PD),image(1,1,[PA,PB,PC,PD],I),imageToHistogram(I,H).

% ------------- ROTATE 90 -----------------

% pixrgb(0,0,1,45,200,10,PA),pixrgb(0,1,123,54,65,20,PB),pixlistRotate90(2,[PA,PB],L).

pixlistRotate90(_,[],[]).
pixlistRotate90(Height,[[[PosX,PosY],Color,Depth]|RestPixels],[[[NewPosX,NewPosY],Color,Depth]|RestPixels2]):-
	NewPosX is (Height - 1 - PosY),
	NewPosY is PosX,
	pixlistRotate90(Height,RestPixels,RestPixels2).

imageRotate90(I1,I2):-
	image(Width,Height,Pixlist1,I1),
	pixlistRotate90(Height,Pixlist1,Pixlist2),
	image(Height,Width,Pixlist2,I2).