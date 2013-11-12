% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 10 de noviembre 2013
% 
% Tarea No:8.2
% 
% Titulo: Deteccion de bordes
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


I = imread('cameraman.tif');

J1=edgefilt(I,'gradient');              %Gradiente
figure
imshow(J1)
title('Gradient')

J2=edgefilt(I,'prewitt');               %Prewitt
figure
imshow(J2)
title('Prewitt')

J3=edgefilt(I,'sobel');                 %Sobel
figure
imshow(J3)
title('Sobel')

I2 = imread('texture.tif');         
J4=edgefilt(I2,'kirsch','N S');         %Kirsch
figure
imshow(mat2gray(J4))
title('Kirsch')

J5=edgefilt(I2,'robinson','N S');       %Robinson
figure
imshow(mat2gray(J5))
title('Robinson')

J6=edgefilt(I2,'newton','N S');         %Newton
figure
 imshow(mat2gray(J6))
title('Newton')

I3=imnoises(I,'uniform',0,0.3);          %se aplica ruido a la imagen para poder filtrarla y aplicar 
                                         %laplacian, log y dog
J7=edgefilt(I3,'laplacian',-8);         %Laplacian
figure
imshow(J7,[])
title('Lapacian')

J8=edgefilt(I3,'log',5,1);              %log
figure
imshow(J8)
title('LoG')


J9=edgefilt(I3,'dog',5,[1.5,1]);        %dog
figure
imshow(J9)
title('DoG')

