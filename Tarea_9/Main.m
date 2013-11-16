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
Salida=freqfilt(I,'lp','ideal',80); %Filtro Ideal
subplot(3,1,1);
%surf(Salida)
%shading interp
imshow(Salida,[]);
title('Ideal LowPass')

Salida=freqfilt(I,'lp','butterworth',80,2); %Filtro Butterworth
subplot(3,1,2);
%surf(Salida)
%shading interp
imshow(Salida,[]);
title('Butterworth LowPass')

Salida=freqfilt(I,'lp','gaussian',80);      %Filtro Gaussian
subplot(3,1,3);
%surf(Salida)
imshow(Salida,[]);
%shading interp
title('Gaussian LowPass')

%/////////////////////////////////////Filtro pasa altas//////////////
figure
Salida=freqfilt(I,'hp','ideal',80);         %Filtro Ideal
subplot(3,1,1);
%surf(Salida)
imshow(Salida,[]);
%shading interp
title('Ideal HighPass')

Salida=freqfilt(I,'hp','butterworth',80,2); %Filtro Butterworth
subplot(3,1,2);
%surf(Salida)
imshow(Salida,[]);
%shading interp
title('Butterworth HighPass')

Salida=freqfilt(I,'hp','gaussian',80);      %Filtro Gaussian
subplot(3,1,3);
%surf(Salida)
imshow(Salida,[]);
%shading interp
title('Gaussian HighPass')


%/////////////////////////////////////Filtro Laplaciano//////////////
figure
Salida==freqlap(I); %Filtro Laplaciano
imshow(Salida,[]);
title('Filtro Laplaciano')

