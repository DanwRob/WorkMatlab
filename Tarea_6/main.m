% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 14 de octubre 2013
% 
% Tarea No:6
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar

%Transformacion lineal

    
img=double(imread('einstein.tif'));   %Se lee la imagen y se transforma a double
   


Salida=histequal(img);
imshow(uint8(Salida));
figure;

bar(0: 255, Salida);
axis([0 255 0 max(Salida)])
