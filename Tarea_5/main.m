% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 14 de octubre 2013
% 
% Tarea No:5
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


    img=double(imread('einstein.tif'));   %Se lee la imagen y se transforma a double
    Salida=imgraytrans(img,'norm',{''});%llama la funcion para aplicar las Transformaciones de intesidad
      img=uint8(img);
      Salida=uint8(Salida);
     
        figure('Name','Practica 5: Transformaciones de intesidad');
        subplot(1,2,1); imshow(img); % Muestra la Imagen Original
        title('Imagen Original') 
        subplot(1,2,2); imshow(Salida); % Muestra la Imagen Tranformada
        title('Imagen Transformada') 
      