:- include(TDAPixel_19527704_AguileraGonzalez)

/*
----------------------------------- TDA IMAGE --------------------------------------

----------------------------------- REPRESENTACIÓN --------------------------------

El TDA Image se representa a través de una lista del tipo [Int x Int x Pixlist x Image]
la cual tiene dimensiones de ancho y alto, una lista de pixeles de tipo pixbit, pixrgb o pixhex,
además de la imagen que es una lista que contiene estos datos.

----------------------------------- DOMINIOS ----------------------------------------

----------------------------- PROVENIENTE DE TDA PIXEL -------------------------------

PosX: Entero >=0 que representa la posición X de un pixel en una imagen.
PosY: Entero >=0 que representa la posición Y de un pixel en una imagen.
Bit: Entero 0 o 1, que representa el "color" de un pixbit.
R, G y B: Enteros (0<= X <=255) que representan los canales de color de un pixrgb.
HexColor: String que representa un color hexadecimal de la forma "#RRGGBB" de un pixhex.
Depth: Entero >=0 que representa la profundidad de cualquier tipo de pixel.
Pixbit: Lista que representa un pixbit
Pixrgb: Lista que representa un pixrgb
Pixhex: Lista que representa un pixhex

------------------------------- PROPIOS DE TDA IMAGE ----------------------------------

Width: Entero > 0 que representa el ancho de una imagen de cualquier tipo.
Height: Entero > 0 que representa el alto de una imagen de cualquier tipo.
NewWidth, NewHeight: Enteros > 0 que representa el ancho o alto de una imagen de cualquier tipo luego de haber sido modificado.
Pixel: Representa un pixel de cualquier tipo pixbit, pixrgb o pixhex.
NewPixel: Representa un pixel de cualquier tipo luego de alguna modificación.
Pixlist: Lista de pixeles (pixbit, pixrgb o pixhex) de una imagen.
Pixlist2: Lista de pixeles luego de haber sido modificada.
Image: Lista que representa una imagen de tipo bitmap, pixmap o hexmap.
Image2: Lista que representa una imagen de tipo bitmap, pixmap o hexmap luego de haber sido modificada.
CompressedColor: Color que puede ser del tipo Bit, RGBColor o HexColor y representa el color de los pixeles comprimidos de la imagen.
CompressedPixels: Lista que representa los pixeles comprimidos de la imagen, guardando la información de su posición (x,y) y su profundidad.
FirstPixel: Representa un pixel de cualquier tipo.
RestPixels, RestPixels2: Lista de pixeles (pixbit, pixrgb o pixhex).
PosX, PosY: Enteros mayores o igual a cero que representan la posición de un pixel dentro de una imagen.
NewPosX, NewPosY: Entero que representa la nueva posición X o Y de un pixel luego de haber sido modificada.
Color: Color que puede ser de tipo Bit, RGBColor o HexColor de un pixel.
FirstColor: Primer color dentro de una lista.
RestColors: Lista de colores.
ColorList: Lista de colores.
ColorCount: Entero que representa la cantidad de veces que se repite un color dentro de una imagen.
RestColorCount: Lista de enteros que representa la frecuencia de colores en una imagen.
X1,Y1,X2,Y2: Enteros que representan coordenadas de dos puntos para definir un cuadrante.
HexLowCase: String que representa un color hexadecimal "rrggbb".
HexUpperCase: String que representa un color hexadecimal "#RRGGBB".
ImageColors: Lista de todos los colores de una imagen, incluso repetidos.
ColorFreqList: Lista de entero que representa la frecuencia de todos los colores de una imagen.
Histogram: Lista que contiene los colores de una imagen con su frecuencia.
String: String que representa una imagen en formato string para ser mostrado en pantalla.
ImageDepths: Lista de enteros que contiene todas las profundidades de los pixeles, incluso los repetidos.
FirstDepth: Entero que representa la profundidad de un pixel en una lista de profundidades.
RestDepths: Lista de profundidades.
DepthList: Lista de enteros que contiene las profunidades de los pixeles de una imagen sin repetir.
ImageList: Lista de imagenes donde cada una contiene pixeles de una única profundidad.

-------------------------------------- PREDICADOS -------------------------------------------

image(Width,Height,Pixlist,Image)

pixlistIsBit(Pixlist)
pixlistIsRGB(Pixlist)
pixlistIsHex(Pixlist)
imageIsBitmap(Image)
imageIsPixmap(Image)
imageIsHexmap(Image)

imageIsCompressed(Image)

pixelFlipH(Width,Pixel,NewPixel)
pixlistFlipH(Width,Pixlist,Pixlist2)
imageFlipH(Image,Image2)

pixelFlipV(Height,Pixel,NewPixel)
pixlistFlipV(Width,Pixlist,Pixlist2)
imageFlipV(Image,Image2)

insideCrop(X1,Y1,X2,Y2,Pixel)
pixlistCrop(X1,Y1,X2,Y2,Pixlist,Pixlist2)
newSize(X1,Y1,X2,Y2,NewWidth,NewHeight)
imageCrop(Image,X1,Y1,X2,Y2,Image2)

pixlistRGBtoHex(Pixlist,Pixlist2)
imageRGBtoHex(Image,Image2)

imageColors(Pixlist,ImageColors)
removeDuplicatedColors(ImageColors,ColorList)
colorFreqList(ColorList,Pixlist,ColorFreqList)
histogram(ColorList,ColorFreqList,Histogram)
imageToHistogram(Image,Histogram)

pixlistRotate90(Height,Pixlist,Pixlist2)
imageRotate90(Image,Image2)

mostFreqColor(ColorList,ColorFreqList,MaxFreq,MostFreqColor)
removeMostFreqColor(MostFreqColor,Pixlist,Pixlist2)
compressedPixels(MostFreqColor,Pixlist,CompressedPixels)
imageCompress(Image,Image2)

changePixel(Pixlist,Pixel,Pixlist2)
imageChangePixel(Image,Pixel,Image2)

invertPixelRGB(Pixel,NewPixel)
imageInvertColorRGB(Pixel,NewPixel)

pixlistToString(Width,Height,0,Pixlist,Pixlist,String)
imageToString(Image,String)

imageDepths(Pixlist,ImageDepths)
removeDuplicatedDepths(ImageDepths,DepthList)
depthImages(Width,Height,Pixlist,DepthList,ImageList)
changeToWhitePixlist(FirstDepth,Pixlist,Pixlist2)
imageDepthLayers(Image,ImageList)

backPixelsToPixlist(CompressedColor,CompressedPixels,Pixlist,Pixlist2)
decompressPixels(CompressedColor,CompressedPixels,DecompressedPixels)
imageDecompress(CompressedImage,DecompressedImage)

---------------------------------------- METAS -------------------------------------------------

PRIMARIAS: 	image, imageIsBitmap, imageIsPixmap, imageIsHexmap, imageIsCompressed, imageFlipH,
			imageFlipV, imageCrop, imageRGBToHex, imageToHistogram, imageRotate90, imageCompress,
			imageChangePixel, imageInvertColorRGB, imageToString, imageDepthLayers, imageDecompress.

SECUNDARIAS:	pixlistIsBit, pixlistIsRGB, pixlistIsHex, pixelFlipH, pixlistFlipH, pixelFlipV, 
				pixlistFlipV, insideCrop, pixlistCrop, newSize, pixlistRGBtoHex, imageColors, 
				removeDuplicatedColors, colorFreqList, histogram, pixlistRotate90, mostFreqColor,
				removeMostFreqColor, compressedPixels, changePixel, invertPixelRGB, pixlistToString,
				imageDepths, removeDuplicatedDepths, depthImages, changeToWhitePixlist, 
				backPixelsToPixlist, decompressPixels.

------------------------------------- CLAUSULAS ------------------------------------------------

---------------------------------- REGLAS Y HECHOS ---------------------------------------------
*/

% ----------------------- CONSTRUCTORES Y FUNCIONES DE PERTENENCIA ----------------------------

% Descripción: Predicado que crea una imagen de cualquier tipo.
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

% Descripción: Predicado que verifica que la lista de pixeles de una imagen esté compuesta por pixbits.
pixlistIsBit([]). 
pixlistIsBit([FirstPixel|RestPixels]):- 
	pixbit(_,_,_,_,FirstPixel),
	pixlistIsBit(RestPixels).

% Descripción: Predicado que verifica que una imagen sea bitmap.
imageIsBitmap([_,_,_,Pixlist,_]):- 
	pixlistIsBit(Pixlist).

% Descripción: Predicado que verifica que la lista de pixeles de una imagen esté compuesta por pixrgb.
pixlistIsRGB([]). 
pixlistIsRGB([FirstPixel|RestPixels]):- 
	pixrgb(_,_,_,_,_,_,FirstPixel),
	pixlistIsRGB(RestPixels).

% Descripción: Predicado que verifica que una imagen sea pixmap.
imageIsPixmap([_,_,_,Pixlist,_]):- 
	pixlistIsRGB(Pixlist).

% Descripción: Predicado que verifica que la lista de pixeles de una imagen esté compuesta por pixhex.
pixlistIsHex([]). 
pixlistIsHex([FirstPixel|RestPixels]):- 
	pixhex(_,_,_,_,FirstPixel),
	pixlistIsHex(RestPixels).

% Descripción: Predicado que verifica que una imagen sea hexmap.
imageIsHexmap([_,_,_,Pixlist,_]):- 
	pixlistIsHex(Pixlist).

% Descripción: Predicado que verifica que la lista de pixeles de una imagen esté compuesta por pixrgb.
imageIsCompressed([Width,Height,[CompressedColor],Pixlist,CompressedPixels]):-
	image(_,_,_,[Width,Height,[CompressedColor],Pixlist,CompressedPixels]).
	

% ---------------------------------------------- MODIFICADORES -------------------------------------------------------

% Descripción: Predicado que voltea una imagen horizontalmente.
imageFlipH(Image,Image2):- 
	image(Width,Height,Pixlist,Image), 
	pixlistFlipH(Width,Pixlist,Pixlist2), 
	image(Width,Height,Pixlist2,Image2).

% Descripción: Predicado que voltea una imagen verticalmente.
imageFlipV(Image,Image2):- 
	image(Width,Height,Pixlist,Image), 
	pixlistFlipV(Height,Pixlist,Pixlist2), 
	image(Width,Height,Pixlist2,Image2).

% Descripción: Predicado que recorta una imagen a partir de un rectángulo definido mediante dos puntos
%			   y entrega una nueva imagen con nuevas dimensiones y los pixeles dentro del corte.
imageCrop(Image,X1,Y1,X2,Y2,Image2):-
	image(Width,Height,Pixlist,Image),
	between(1,Width,X2), between(1,Width,X2), 
	between(1,Height,Y1), between(1,Height,Y2), 
	X1 =< X2, Y1 =< Y2,
	pixlistCrop(X1,Y1,X2,Y2,Pixlist,Pixlist2),
	newSize(X1,Y1,X2,Y2,NewWidth,NewHeight),
	image(NewWidth,NewHeight,Pixlist2,Image2).

% Descripción: Predicado que cambia una imagen pixmap a hexmap.
imageRGBtoHex(Image,Image2):-
	image(Width,Height,Pixlist,Image),
	imageIsPixmap(Image),
	pixlistRGBtoHex(Pixlist,Pixlist2),
	image(Width,Height,Pixlist2,Image2).

% Descripción: Entrega una lista del tipo [Color, Freq] para todos los colores de una imagen.
imageToHistogram(Image, Histogram):-
	image(_,_,Pixlist,Image),
	imageColors(Pixlist,ImageColors),
	removeDuplicatedColors(ImageColors,ColorList),
	colorFreqList(ColorList,Pixlist,ColorFreqList),
	histogram(ColorList,ColorFreqList,Histogram).

% Descripción: Predicado que entrega una nueva imagen tras rotar la imagen original en 90 grados en sentido horario (derecha).
imageRotate90(Image,Image2):-
	image(Width,Height,Pixlist,Image),
	pixlistRotate90(Height,Pixlist,Pixlist2),
	sort(Pixlist2,Pixlist3),
	image(Height,Width,Pixlist3,Image2).

% Descripción: Predicado que comprime una imagen a partir de su color más frecuente,
%			   eliminando los pixeles que lo contienen.
imageCompress(Image,[Width,Height,[MostFreqColor],Pixlist2,CompressedPixels]):-
	image(Width,Height,Pixlist,Image),
	imageColors(Pixlist,ImageColors),
	removeDuplicatedColors(ImageColors,ColorList),
	colorFreqList(ColorList,Pixlist,ColorFreqList),
	mostFreqColor(ColorList,ColorFreqList,_,MostFreqColor),
	removeMostFreqColor(MostFreqColor,Pixlist,Pixlist2),
	compressedPixels(MostFreqColor,Pixlist,CompressedPixels),
	image(_,_,_,[Width,Height,[MostFreqColor],Pixlist2,CompressedPixels]).

% Descripción: Predicado que invierte los canales RGB de un pixel pixrgb.
imageInvertColorRGB([[PosX,PosY],[R,G,B],Depth],[[PosX,PosY],[NewR,NewG,NewB],Depth]):-
	pixrgb(_,_,_,_,_,_,[[PosX,PosY],[R,G,B],Depth]),
	NewR is (255 - R),
	NewG is (255 - G),
	NewB is (255 - B),
	pixrgb(_,_,_,_,_,_,[[PosX,PosY],[NewR,NewG,NewB],Depth]),.

% Descripción: Predicado que descomprime una imagen comprimida previamente.
imageDecompress([Width,Height,[CompressedColor],Pixlist,CompressedPixels],DecompressedImage):-
	image(_,_,_,[Width,Height,[CompressedColor],Pixlist,CompressedPixels]),
	backPixelsToPixlist(CompressedColor,CompressedPixels,Pixlist,Pixlist2),
	sort(Pixlist2,SortPixlist),
	image(Width,Height,SortPixlist,DecompressedImage).

% ---------------------------------------- OTROS PREDICADOS ---------------------------------------------

% Descripción: Predicado que modifica la posición X de un pixel al ser volteado horizontalmente.	
pixelFlipH(Width,[[PosX,PosY],Color,Depth],[[NewPosX,PosY],Color,Depth]):-
	NewPosX is (Width - PosX - 1).

% Descripción: Predicado que modifica la posición X de una lista de pixeles.
pixlistFlipH(_,[],[]).
pixlistFlipH(Width,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipH(Width,FirstPixel,NewPixel),
	pixlistFlipH(Width,RestPixels,RestPixels2).

% Descripción: Predicado que modifica la posición Y de un pixel al ser volteado verticalmente.
pixelFlipV(Height,[[PosX,PosY],Color,Depth],[[PosX,NewPosY],Color,Depth]):-
	NewPosY is (Height - PosY - 1).

% Descripción: Predicado que modifica la posición Y de una lista de pixeles.
pixlistFlipV(_,[],[]).
pixlistFlipV(Height,[FirstPixel|RestPixels],[NewPixel|RestPixels2]):- 
	pixelFlipV(Height,FirstPixel,NewPixel),
	pixlistFlipV(Height,RestPixels,RestPixels2).

% Descripción: Predicado que verifica que un pixel se encuentre dentro del rectangulo de corte.
insideCrop(X1,Y1,X2,Y2,[[PosX,PosY],_,_]):-
	between(X1,X2,PosX),
	between(Y1,Y2,PosY).

% Descripción: Predicado que entrega una lista con los pixeles que están dentro del rectángulo de corte.
pixlistCrop(_,_,_,_,[],[]).
pixlistCrop(X1,Y1,X2,Y2,[[[PosX,PosY],Color,Depth]|RestPixels],[[[NewPosX,NewPosY],Color,Depth]|RestPixels2]):-
	insideCrop(X1,Y1,X2,Y2,[[PosX,PosY],Color,Depth]),
	NewPosX is (PosX - X1), NewPosY is (PosY - Y1),
	pixlistCrop(X1,Y1,X2,Y2,RestPixels,RestPixels2).
pixlistCrop(X1,Y1,X2,Y2,[FirstPixel|RestPixels],RestPixels2):-
	not(insideCrop(X1,Y1,X2,Y2,FirstPixel)),
	pixlistCrop(X1,Y1,X2,Y2,RestPixels,RestPixels2).

% Descripción: Modifica las dimensiones de la imagen tras ser cortada.
newSize(X1,Y1,X2,Y2,NewWidth,NewHeight):-
	NewWidth is (X2 - X1 + 1),
	NewHeight is (Y2 - Y1 + 1).

% Descripción: Cambia el color RGB a hexadecimal de una lista de pixeles pixrgb.
pixlistRGBtoHex([],[]).
pixlistRGBtoHex([[[PosX,PosY],RGBColor,Depth]|RestPixels],[[[PosX,PosY],HexColor,Depth]|RestPixels2]):-
	hex_bytes(HexLowCase,RGBColor),
	string_upper(HexLowCase,HexUpperCase),
	string_concat("#",HexUpperCase,HexColor),
	pixlistRGBtoHex(RestPixels,RestPixels2).

% Descripción: Predicado que entrega una lista con todos los colores de una imagen incluyendo repetidos.
imageColors([],[]).
imageColors([[_,Color,_]|RestPixels],[Color|RestColors]):-
	imageColors(RestPixels,RestColors).

% Descripción: Elimina los colores repetidos de una lista de colores.
removeDuplicatedColors([],[]).
removeDuplicatedColors([FirstColor|RestColors],ColorList):-
	member(FirstColor,RestColors), !,
	removeDuplicatedColors(RestColors,ColorList).
removeDuplicatedColors([FirstColor|RestColors],[FirstColor|ColorList]):-
	removeDuplicatedColors(RestColors,ColorList).

% Descripción: Predicado que entrega la frecuencia de los colores a partir de una lista de colores.
colorFreqList([],_,[]).
colorFreqList([FirstColor|RestColors],Pixlist,[ColorCount|RestColorCount]):-
	colorFreq(FirstColor,Pixlist,ColorCount),
	colorFreqList(RestColors,Pixlist,RestColorCount).

% Descripción: Entrega la frecuencia de un color determinado a partir de una lista de colores.
colorFreq(_,[],0).
colorFreq(Color,[[_,Color,_]|RestPixels],ColorCount):-
	!, colorFreq(Color,RestPixels,ColorCount2),
	ColorCount is (ColorCount2 + 1).
colorFreq(Color,[_|RestPixels],ColorCount):-
	colorFreq(Color, RestPixels, ColorCount).

% Descripción: Entrega una lista del tipo [Color, Freq] para todos los colores de una imagen.
histogram([],[],[]).
histogram([FirstColor|RestColors],[FirstFreq|RestFreq],[[FirstColor,FirstFreq]|RestElements]):-
	histogram(RestColors,RestFreq,RestElements).

% Descripción: Entrega el color que más se repite a partir de una lista colores y otra de frecuencias.
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

% Descripción: Predicado que rota todos los pixeles de una lista.
pixlistRotate90(_,[],[]).
pixlistRotate90(Height,[[[PosX,PosY],Color,Depth]|RestPixels],[[[NewPosX,NewPosY],Color,Depth]|RestPixels2]):-
	NewPosX is (Height - 1 - PosY),
	NewPosY is PosX,
	pixlistRotate90(Height,RestPixels,RestPixels2).

% Descripción: Entrega una lista de pixeles sin los que tienen el color más frecuente en la imagen.
removeMostFreqColor(_,[],[]).
removeMostFreqColor(Color,[[_,Color,_]|RestPixels],RestPixels2):-
	removeMostFreqColor(Color,RestPixels,RestPixels2).
removeMostFreqColor(Color,[[[PosX,PosY],Color2,Depth]|RestPixels],[[[PosX,PosY],Color2,Depth]|RestPixels2]):-
	Color2 \= Color,
	removeMostFreqColor(Color,RestPixels,RestPixels2).

% Descripción: Entrega una lista de pixeles comprimidos con información de su posición y profundidad.
compressedPixels(_,[],[]).
compressedPixels(Color,[[[PosX,PosY],Color,Depth]|RestPixels],[[PosX,PosY,Depth]|RestCompressedPixels]):-
	compressedPixels(Color,RestPixels,RestCompressedPixels).
compressedPixels(Color,[[_,Color2,_]|RestPixels],RestCompressedPixels):-
	Color2 \= Color,
	compressedPixels(Color,RestPixels,RestCompressedPixels).

% Descripción: Predicado que convierte una lista de pixeles en una representación string para mostrar en pantalla.
pixlistToString(_,Height,Row,[[[_,_],_,_]|_],_,""):-
	Row =:= Height.
pixlistToString(Width,Height,Row,[[[PosX,PosY],Color,_]|RestPixels],Pixlist,String):-
	PosX =\= (Width - 1),
	Row =:= PosY,
	term_string(Color,StringColor),
	string_concat(StringColor," ",StringColor2),
	pixlistToString(Width,Height,Row,RestPixels,Pixlist,String2),
	string_concat(StringColor2,String2,String).
pixlistToString(Width,Height,Row,[[[_,PosY],_,_]|RestPixels],Pixlist,String):-
	Row =\= PosY,
	pixlistToString(Width,Height,Row,RestPixels,Pixlist,String).
pixlistToString(Width,Height,Row,[[[PosX,PosY],Color,_]|_],Pixlist,String):-
	PosX =:= (Width - 1),
	Row =:= PosY,
	term_string(Color,StringColor),
	string_concat(StringColor,"\n",StringColor2),
	NextRow is (Row + 1),
	pixlistToString(Width,Height,NextRow,Pixlist,Pixlist,String2),
	string_concat(StringColor2,String2,String).

% Descripción: Predicado que convierte una imagen en una representación string para ser mostrada en pantalla.
imageToString([Width,Height,[],Pixlist,[]],String):-
	image(Width,Height,Pixlist,[Width,Height,[],Pixlist,[]]),
	sort(Pixlist,SortPixlist),
	pixlistToString(Width,Height,0,SortPixlist,SortPixlist,String).

% Descripción: Predicado que entrega una lista con las profundidades de los pixeles de una imagen incluidos los repetidos.
imageDepths([],[]).
imageDepths([[_,_,Depth]|RestPixels],[Depth|RestDepths]):-
	imageDepths(RestPixels,RestDepths).

% Descripción: Predicado que elimina las profundidades repetidas.
removeDuplicatedDepths([],[]).
removeDuplicatedDepths([FirstDepth|RestDepths],DepthList):-
	member(FirstDepth,RestDepths), !,
	removeDuplicatedDepths(RestDepths,DepthList).
removeDuplicatedDepths([FirstDepth|RestDepths],[FirstDepth|DepthList]):-
	removeDuplicatedDepths(RestDepths,DepthList).

% Descripción: Predicado que cambia el color de un pixel a blanco y la profundidad.
changeToWhitePixlist(_,[],[]).
changeToWhitePixlist(NewDepth,[[[PosX,PosY],Color,OldDepth]|RestPixels],[[[PosX,PosY],1,NewDepth]|RestPixels2]):-
	pixbit(_,_,_,_,[[PosX,PosY],Color,OldDepth]),
	NewDepth =\= OldDepth,
	changeToWhitePixlist(NewDepth,RestPixels,RestPixels2).
changeToWhitePixlist(NewDepth,[[[PosX,PosY],Color,OldDepth]|RestPixels],[[[PosX,PosY],[255,255,255],NewDepth]|RestPixels2]):-
	pixrgb(_,_,_,_,_,_,[[PosX,PosY],Color,OldDepth]),
	NewDepth =\= OldDepth,
	changeToWhitePixlist(NewDepth,RestPixels,RestPixels2).
changeToWhitePixlist(NewDepth,[[[PosX,PosY],Color,OldDepth]|RestPixels],[[[PosX,PosY],"#FFFFFF",NewDepth]|RestPixels2]):-
	pixhex(_,_,_,_,[[PosX,PosY],Color,OldDepth]),
	NewDepth =\= OldDepth,
	changeToWhitePixlist(NewDepth,RestPixels,RestPixels2).
changeToWhitePixlist(Depth,[[[PosX,PosY],Color,Depth]|RestPixels],[[[PosX,PosY],Color,Depth]|RestPixels2]):-
	changeToWhitePixlist(Depth,RestPixels,RestPixels2).

% Descripción: Predicado que entrega una lista de imagenes donde todos los pixeles de cada imagen tienen la misma profundidad.
depthImages(_,_,_,[],[]).
depthImages(Width,Height,Pixlist,[FirstDepth|RestDepths],[[Width,Height,[],Pixlist2,[]]|RestImages]):-
	changeToWhitePixlist(FirstDepth,Pixlist,Pixlist2),
	depthImages(Width,Height,Pixlist,RestDepths,RestImages).

% Descripción: Predicado que entrega una lista de imagenes donde todos los pixeles de cada imagen tienen la misma profundidad.
imageDepthLayers([Width,Height,[],Pixlist,[]],ImageList):-
	imageDepths(Pixlist,ImageDepths),
	removeDuplicatedDepths(ImageDepths,DepthList),
	depthImages(Width,Height,Pixlist,DepthList,ImageList).

% Descripción: Predicado que entrega una lista de pixeles luego agregar los pixeles comprimidos previamente.
backPixelsToPixlist(CompressedColor,CompressedPixels,Pixlist,FinalPixlist):-
	decompressPixels(CompressedColor,CompressedPixels,DecompressedPixels),
	append(DecompressedPixels,Pixlist,FinalPixlist).

% Descripción: Predicado que entrega los pixeles comprimidos en un formato para ser integrados a la imagen nuevamente.
decompressPixels(_,[],[]).
decompressPixels(CompressedColor,[[PosX,PosY,Depth]|RestCompressedPixels],[[[PosX,PosY],CompressedColor,Depth]|RestPixels]):-
	decompressPixels(CompressedColor,RestCompressedPixels,RestPixels).
