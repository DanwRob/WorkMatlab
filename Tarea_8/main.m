% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 10 de noviembre 2013
% 
% Tarea No:7
% 
% Titulo: Tipos de Ruido
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


I = imread('board_salt_pepper.tif');

J1=splfilt(I,'gaussian',5,1);
figure
imshow(J1)
title('Gaussiano')

J2=splfilt(I,'amean',5);
figure
imshow(J2)
title('Media aritmietica')

J3=splfilt(I,'gmean',5);
figure
imshow(uint8(J3*255))
title('Media geometrica')

J4=splfilt(I,'hmean',5);
figure
imshow(uint8(J4*255))
title('Medias harmonico')

J5=splfilt(I,'chmean',3,1.5);
figure
imshow(uint8(J5*255))
title('Contraharmonic mean')

J6=splfilt(I,'median',5);
figure
imshow(uint8(J6*255))
title('Median')

J7=splfilt(I,'hybmedian',5);
figure
imshow(uint8(J7*255))
title('Hybmedian')

J8=splfilt(I,'max',5);
figure
imshow(uint8(J8*255))
title('Min')

J9=splfilt(I,'min',5);
figure
imshow(uint8(J9*255))
title('Max')

J10=splfilt(I,'midpoint',5);
figure
imshow(uint8(J10*255))
title('Midpoint')

