/* ---------------------------------- TDA PIXEL ----------------------------------

----------------------------------- REPRESENTACIÓN --------------------------------

El TDA Pixel se representa a través de una lista del tipo [Int x Int x Color x Int x Pixel]
la cual tiene posición en x e y, color dependiendo del tipo de pixel, profundidad y el pixel
representado en una lista [[Int,Int],Color,Depth].

------------------------------------ DOMINIOS --------------------------------------

PosX: Entero >=0 que representa la posición X de un pixel en una imagen.
PosY: Entero >=0 que representa la posición Y de un pixel en una imagen.
Bit: Entero 0 o 1, que representa el "color" de un pixbit.
R, G y B: Enteros (0<= X <=255) que representan los canales de color de un pixrgb.
HexColor: String que representa un color hexadecimal de la forma "#RRGGBB" de un pixhex.
Depth: Entero >=0 que representa la profundidad de cualquier tipo de pixel.
Pixbit: Lista que representa un pixbit
Pixrgb: Lista que representa un pixrgb
Pixhex: Lista que representa un pixhex

---------------------------- PREDICADOS ----------------------------------

pixbit(PosX,PosY,Bit,Depth,Pixbit)
pixrgb(PosX,PosY,R,G,B,Depth,Pixrgb)
pixhex(PosX,PosY,HexColor,Depth,Pixhex)
bitColor(Bit)
rgbColor([R,G,B])
hexColor(HexColor)

---------------------------------------- METAS -------------------------------------------------

PRIMARIAS: 	pixbit, pixrgb, pixhex.
SECUNDARIAS: bitColor, rgbColor, hexColor.

------------------------------------- CLAUSULAS ------------------------------------------------

---------------------------------- REGLAS Y HECHOS ---------------------------------------------
*/

% ----------------------- CONSTRUCTORES Y FUNCIONES DE PERTENENCIA ------------------------------

% Descripción: Predicado que crea un pixel tipo pixbit-d.
pixbit(PosX,PosY,Bit,Depth,[[PosX,PosY],Bit,Depth]) :- 
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	bitColor(Bit),
	integer(Depth), 0=<Depth.

% Descripción: Predicado que crea un pixel tipo pixrgb-d.
pixrgb(PosX,PosY,R,G,B,Depth,[[PosX,PosY],[R,G,B],Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	rgbColor([R,G,B]),
	integer(Depth), 0=<Depth.

% Descripción: Predicado que crea un pixel tipo pixhex-d.
pixhex(PosX,PosY,HexColor,Depth,[[PosX,PosY],HexColor,Depth]) :-
	integer(PosX), 0=<PosX,
	integer(PosY), 0=<PosY,
	hexColor(HexColor),
	integer(Depth), 0=<Depth.

% Descripción: Predicado que verifica si el color es de tipo bitColor.
bitColor(Bit):-
	(Bit is 0; Bit is 1).

% Descripción: Predicado que verifica si el color es tipo rgbColor.
rgbColor([R,G,B]):-
	integer(R), between(0, 255, R),
	integer(G), between(0, 255, G),
	integer(B), between(0, 255, B).

% Descripción: Predicado que verifica si el color es tipo hexColor.
hexColor(HexColor):-
	string(HexColor),
	string_length(HexColor,7),
	sub_string(HexColor,0,1,6,"#").

% ---------------------------------- MODIFICADORES ---------------------------------

% Descripción: Predicado que cambia la información de un pixel de una imagen.
changePixel([],_,[]).
changePixel([[[PosX,PosY],_,_]|RestPixels],[[PosX,PosY],Color,Depth],[[[PosX,PosY],Color,Depth]|RestPixels]).
changePixel([FirstPixel|RestPixels],Pixel,[FirstPixel|RestPixels2]):-
	changePixel(RestPixels,Pixel,RestPixels2).

% Descripción: Predicado que cambia la información del pixel de una imagen 
%			   entregando una nueva imagen con este nuevo pixel.
imageChangePixel([Width,Height,[],Pixlist,[]], Pixel, [Width,Height,[],Pixlist2,[]]):-
	image(_,_,_,[Width,Height,[],Pixlist,[]]),
	changePixel(Pixlist,Pixel,Pixlist2),
	image(_,_,_,[Width,Height,[],Pixlist2,[]]).