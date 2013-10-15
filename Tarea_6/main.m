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

    
    img=double(imread('new.bmp'));   %Se lee la imagen y se transforma a double
   
    Salida=histequal(img);

figure;
bar(Salida);
axis([0 256 0 max(Salida)])