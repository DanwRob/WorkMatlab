% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 19 de Septiembre 2013
% 
% Tarea No:1
% 
% Titulo: Leer un archivo BMP con color indexado de 8-bits
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('bus_8bits_color.bmp','r');% Se abre la imagen con fopen y con permisos de lectura
i2 = fopen('bus_8bits_gray.bmp','r');% Se abre la imagen con fopen y con permisos de lectura
if(i1~=-1&&i2~=-1)
    
    [Isalida,flag]=readbmp(i1);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
    [Isalida2,flag2]=readbmp(i2);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
    
    if(flag~=0&&flag2~=0)
        %Isalida2=uint8(Isalida2);
        figure('Name','Practica 1: Leer un archivo BMP con color indexado de 8-bits');
        subplot(1,2,1); imshow(Isalida); % Muestra la Imagen 1
        title('BMP de 8 bits a color') 
        subplot(1,2,2); imshow(Isalida2,[]); % Muestra la imagen 2
        title('BMP de 8 bits a escala de grises') 
        fclose(i1);
        fclose(i2);
   
    end
else
    Error='Imagen no existe favor de verificar ruta'
end



