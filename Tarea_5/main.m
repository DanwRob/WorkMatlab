% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 30 de Septiembre 2013
% 
% Tarea No:5
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



%%i1 = fopen('letra_k.bmp','r');% Se abre la imagen con fopen y con permisos de lectura

    
    %%[Isalida,flag]=readbmp(i1);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
    img=double(imread('aerial.tif'));
    Salida=imgraytrans(img,'exp',{'0.025'});%llama la funcion para aplicar las transformaciones
    img=uint8(img);
      Salida=uint8(Salida);
        figure('Name','Practica 2: Tranformadas Geometricas');
        subplot(1,2,1); imshow(img); % Muestra la Imagen Original
        title('Imagen Original') 
        subplot(1,2,2); imshow(Salida); % Muestra la Imagen Tranformada
        title('Imagen Transformada') 