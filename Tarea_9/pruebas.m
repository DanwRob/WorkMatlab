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


I =double (imread('patterns.bmp'));


%/////////////////////////////////////Filtro pasa altas//////////////
figure
Salida=freqfilt(I,'hp','gaussian',20,2); %Filtro Ideal
subplot(1,3,1);
%surf(Salida)
%shading interp
imshow(Salida,[]);
title('Ideal LowPass D0=20')

Salida=freqfilt(I,'hp','gaussian',40,2); %Filtro Ideal
subplot(1,3,2);
%surf(Salida)
%shading interp
imshow(Salida,[]);
title('Ideal LowPass D0=40')

Salida=freqfilt(I,'hp','gaussian',80,2); %Filtro Ideal
subplot(1,3,3);
%surf(Salida)
%shading interp
imshow(Salida,[]);
title('Ideal LowPass D0=80')



