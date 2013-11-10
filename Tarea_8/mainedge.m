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


I = imread('cameraman.tif');

J1=edgefilt(I,'gradient');
figure
imshow(J1)
title('Gradient')

J2=edgefilt(I,'prewitt');
figure
imshow(J2)
title('Prewitt')

J3=edgefilt(I,'sobel');
figure
imshow(J3)
title('Sobel')

I2 = imread('texture.tif');
J4=edgefilt(I2,'kirsch','N S');
figure
imshow(mat2gray(J4))
title('Kirsch')

J5=edgefilt(I2,'robinson','N S');
figure
imshow(mat2gray(J5))
title('Robinson')

J6=edgefilt(I2,'newton','N S');
figure
 imshow(mat2gray(J6))
title('Newton')

I3=imnoises(I,'uniform',0,0.3);
J7=edgefilt(I,'laplacian',-8);
figure
imshow(J7,[])
title('Lapacian')

J8=edgefilt(I3,'log',5,1);
figure
imshow(J8)
title('LoG')


J9=edgefilt(I3,'dog',5,[1.5,1]);
figure
imshow(J9)
title('DoG')

