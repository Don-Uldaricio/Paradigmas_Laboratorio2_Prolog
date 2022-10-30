pixbit(PosX,PosY,Bit,Depth,[[PosX,PosY],Bit,Depth]) :- 
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	bitColor(Bit),
	integer(Depth), 0=<Depth.

pixrgb(PosX,PosY,R,G,B,Depth,[[PosX,PosY],[R,G,B],Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	rgbColor([R,G,B]),
	integer(Depth), 0=<Depth.

pixhex(PosX,PosY,HexColor,Depth,[[PosX,PosY],HexColor,Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	hexColor(HexColor),
	integer(Depth), 0=<Depth.

bitColor(Bit):-
	(Bit is 0; Bit is 1).

rgbColor([R,G,B]):-
	integer(R), between(0, 255, R),
	integer(G), between(0, 255, G),
	integer(B), between(0, 255, B).

hexColor(HexColor):-
	string(HexColor),
	string_length(HexColor,7),
	sub_string(HexColor,0,1,6,"#").


% ----------------------- CONSTRUCTOR ----------------------------

image(Width,Height,Pixlist,[Width,Height,[CompressedColor],Pixlist,CompressedPixels]):-
	integer(Width), 0=<Width,
	integer(Height), 0=<Height,
	(pixlistIsBit(Pixlist); pixlistIsRGB(Pixlist); pixlistIsHex(Pixlist)),
	(bitColor(CompressedColor);rgbColor(CompressedColor);hexColor(CompressedColor)),
	is_list(CompressedPixels).

image(Width,Height,Pixlist,[Width,Height,[],Pixlist,[]]) :-
	integer(Width), 0=<Width,
	integer(Height), 0=<Height,
	(pixlistIsBit(Pixlist); pixlistIsRGB(Pixlist); pixlistIsHex(Pixlist)).

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

% ------------ IsCompressed -------------------------

imageIsCompressed([Width,Height,[CompressedColor],Pixlist,CompressedPixels]):-
	image(_,_,_,[Width,Height,[CompressedColor],Pixlist,CompressedPixels]).
	

%---------- OTROS PREDICADOS --------------------

% ---------------FLIPH ---------------------------------
	
pixelFlipH(Width,[[PosX,PosY],Color,Depth],[[NewPosX,PosY],Color,Depth]):-
	NewPosX is (Width - PosX - 1).

pixlistFlipH(_,[],[]).
pixlistFlipH(Width,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipH(Width,FirstPixel,NewPixel),
	pixlistFlipH(Width,RestPixels,RestPixels2).

imageFlipH(Image,Image2):- 
	image(Width,Height,Pixlist,Image), 
	pixlistFlipH(Width,Pixlist,Pixlist2), 
	image(Width,Height,Pixlist2,Image2).

% ------------------------ FLIPV -----------------

pixelFlipV(Height,[[PosX,PosY],Color,Depth],[[PosX,NewPosY],Color,Depth]):-
	NewPosY is (Height - PosY - 1).

pixlistFlipV(_,[],[]).
pixlistFlipV(Height,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipV(Height,FirstPixel,NewPixel),
	pixlistFlipV(Height,RestPixels,RestPixels2).

imageFlipV(Image,Image2):- 
	image(Width,Height,Pixlist,Image), 
	pixlistFlipV(Height,Pixlist,Pixlist2), 
	image(Width,Height,Pixlist2,Image2).

% ---------------------- CROP ----------------------

insideCrop(X1,Y1,X2,Y2,[[PosX,PosY],_,_]):-
	between(X1,X2,PosX),
	between(Y1,Y2,PosY).

pixlistCrop(_,_,_,_,[],[]).
pixlistCrop(X1,Y1,X2,Y2,[[[PosX,PosY],Color,Depth]|RestPixels],[[[NewPosX,NewPosY],Color,Depth]|RestPixels2]):-
	insideCrop(X1,Y1,X2,Y2,[[PosX,PosY],Color,Depth]),
	NewPosX is (PosX - X1), NewPosY is (PosY - Y1),
	pixlistCrop(X1,Y1,X2,Y2,RestPixels,RestPixels2).
pixlistCrop(X1,Y1,X2,Y2,[FirstPixel|RestPixels],RestPixels2):-
	not(insideCrop(X1,Y1,X2,Y2,FirstPixel)),
	pixlistCrop(X1,Y1,X2,Y2,RestPixels,RestPixels2).

newSize(X1,Y1,X2,Y2,NewWidth,NewHeight):-
	NewWidth is (X2 - X1 + 1),
	NewHeight is (Y2 - Y1 + 1).

imageCrop(Image,X1,Y1,X2,Y2,Image2):-
	image(Width,Height,Pixlist,Image),
	between(1,Width,X2), between(1,Width,X2), 
	between(1,Height,Y1), between(1,Height,Y2), 
	X1 =< X2, Y1 =< Y2,
	pixlistCrop(X1,Y1,X2,Y2,Pixlist,Pixlist2),
	newSize(X1,Y1,X2,Y2,NewWidth,NewHeight),
	image(NewWidth,NewHeight,Pixlist2,Image2).

%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),pixbit(2,1,1,4,PF),image(3,2,[PA,PB,PC,PD,PE,PF],I1),imageCrop(I1,0,0,1,1,I2).
%pixrgb(0,0,1,45,200,10,PA),pixrgb(0,1,123,54,65,20,PB),pixlistRGBtoHex([PA,PB],L).

% ----------------------- RGB to HEX -----------------

pixlistRGBtoHex([],[]).
pixlistRGBtoHex([[[PosX,PosY],RGBColor,Depth]|RestPixels],[[[PosX,PosY],HexColor,Depth]|RestPixels2]):-
	hex_bytes(HexLowCase,RGBColor),
	string_upper(HexLowCase,HexUpperCase),
	string_concat("#",HexUpperCase,HexColor),
	pixlistRGBtoHex(RestPixels,RestPixels2).

imageRGBtoHex(Image,Image2):-
	image(Width,Height,Pixlist,Image),
	imageIsPixmap(Image),
	pixlistRGBtoHex(Pixlist,Pixlist2),
	image(Width,Height,Pixlist2,Image2).

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

imageRotate90(Image,Image2):-
	image(Width,Height,Pixlist,Image),
	pixlistRotate90(Height,Pixlist,Pixlist2),
	sort(Pixlist2,Pixlist3),
	image(Height,Width,Pixlist3,Image2).

% ------------------- COMPRESS ---------------------

mostFreqColor([],[],0,[]).
mostFreqColor([FirstColor|RestColors],[FirstFreq|RestFreq],Max,Color):-
	mostFreqColor(RestColors,RestFreq,TailMax,_),
	FirstFreq > TailMax,
	Max is FirstFreq,
	Color = FirstColor.
mostFreqColor([_|RestColors],[FirstFreq|RestFreq],Max,Color):-
	mostFreqColor(RestColors,RestFreq,TailMax,TailColor),
	FirstFreq =< TailMax,
	Max is TailMax,
	Color = TailColor.

%mostFreqColor([0,1],[2,5],Max,Color).

removeMostFreqColor(_,[],[]).
removeMostFreqColor(Color,[[_,Color,_]|RestPixels],RestPixels2):-
	removeMostFreqColor(Color,RestPixels,RestPixels2).
removeMostFreqColor(Color,[[[PosX,PosY],Color2,Depth]|RestPixels],[[[PosX,PosY],Color2,Depth]|RestPixels2]):-
	Color2 \= Color,
	removeMostFreqColor(Color,RestPixels,RestPixels2).

compressedPixels(_,[],[]).
compressedPixels(Color,[[[PosX,PosY],Color,Depth]|RestPixels],[[PosX,PosY,Depth]|RestCompressedPixels]):-
	compressedPixels(Color,RestPixels,RestCompressedPixels).
compressedPixels(Color,[[_,Color2,_]|RestPixels],RestCompressedPixels):-
	Color2 \= Color,
	compressedPixels(Color,RestPixels,RestCompressedPixels).


%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),removeMostFreqColor(0,[PA,PB,PC,PD,PE],CL).
%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),compressedPixels(1,[PA,PB,PC,PD,PE],CP).
%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,1,4,PD),pixbit(2,0,1,4,PE),image(1,1,[PA,PB,PC,PD,PE],I),imageCompress(I,I2).


imageCompress(Image,[Width,Height,[MostFreqColor],Pixlist2,CompressedPixels]):-
	image(Width,Height,Pixlist,Image),
	imageColors(Pixlist,ImageColors),
	removeDuplicatedColors(ImageColors,ColorList),
	colorFreqList(ColorList,Pixlist,ColorFreqList),
	mostFreqColor(ColorList,ColorFreqList,_,MostFreqColor),
	removeMostFreqColor(MostFreqColor,Pixlist,Pixlist2),
	compressedPixels(MostFreqColor,Pixlist,CompressedPixels),
	image(_,_,_,[Width,Height,[MostFreqColor],Pixlist2,CompressedPixels]).

% ------------------ CHANGEPIXEL ---------------------

%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),changePixel([PA,PB,PC],[[0,1],1,567],PL).
%pixbit(0,0,1,10,PA),pixbit(0,1,0,20,PB),pixbit(1,0,0,30,PC),pixbit(1,1,0,13,PD),image(2,2,[PA,PB,PC,PD],I),imageChangePixel(I,[[0,1],1,540],I2).

changePixel([],_,[]).
changePixel([[[PosX,PosY],_,_]|RestPixels],[[PosX,PosY],Color,Depth],[[[PosX,PosY],Color,Depth]|RestPixels]).
changePixel([FirstPixel|RestPixels],Pixel,[FirstPixel|RestPixels2]):-
	changePixel(RestPixels,Pixel,RestPixels2).

imageChangePixel([Width,Height,[],Pixlist,[]], Pixel, [Width,Height,[],Pixlist2,[]]):-
	image(_,_,_,[Width,Height,[],Pixlist,[]]),
	changePixel(Pixlist,Pixel,Pixlist2),
	image(_,_,_,[Width,Height,[],Pixlist2,[]]).

% -------------------- invertColorRGB --------------------------

invertPixelRGB([[PosX,PosY],[R,G,B],Depth],[[PosX,PosY],[NewR,NewG,NewB],Depth]):-
	NewR is (255 - R),
	NewG is (255 - G),
	NewB is (255 - B).

imageInvertColorRGB(Pixel,NewPixel):-
	pixrgb(_,_,_,_,_,_,Pixel),
	invertPixelRGB(Pixel,NewPixel).