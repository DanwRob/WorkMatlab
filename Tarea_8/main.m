% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 10 de noviembre 2013
% 
% Tarea No:8.1
% 
% Titulo: Filtrados
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


I = imread('board_gaussian.tif');

J1=splfilt(I,'gaussian',5,1);           %filtrado gaussiano
figure
imshow(J1)
title('Gaussiano')

J2=splfilt(I,'amean',5);                %filtrado media aritmetica
figure
imshow(J2)
title('Media aritmietica')

J3=splfilt(I,'gmean',5);                %filtrado media geometrica
figure
imshow(uint8(J3*255))
title('Media geometrica')

J4=splfilt(I,'hmean',5);                %filtrado media harmonica
figure
imshow(uint8(J4*255))
title('Medias harmonico')

J5=splfilt(I,'chmean',3,1.5);           %filtrado contraharmonica
figure
imshow(uint8(J5*255))
title('Contraharmonic mean')

J6=splfilt(I,'median',5);               %filtrado mediana
figure
imshow(uint8(J6*255))
title('Median')

J7=splfilt(I,'hybmedian',5);            %filtrado mediana hibrida
figure
imshow(uint8(J7*255))
title('Hybmedian')

J8=splfilt(I,'max',3);                  %filtrado minimo
figure
imshow(uint8(J8*255))
title('Max')
    
J9=splfilt(I,'min',5);                  %filtrado maximo
figure
imshow(uint8(J9*255))
title('Min')

J10=splfilt(I,'midpoint',3);            %filtrado punto medio
figure
imshow(uint8(J10*255))
title('Midpoint')

