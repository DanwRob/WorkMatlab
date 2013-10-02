% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 19 de Septiembre 2013
% 
% Tarea No:2
% 
% Titulo: Leer un archivo BMP con color indexado de 8-bits
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('bw2.bmp','r');% Se abre la imagen con fopen y con permisos de lectura
if(i1~=-1)
    
    [Isalida,flag]=readbmp(i1);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
   
    Salida=bwlabeling(Isalida);
    
    Salida=label2rgb(Salida);
    if(flag~=0)
        
        figure('Name','Practica 1: Leer un archivo BMP con color indexado de 8-bits');
        subplot(1,2,1); imshow(Isalida,[]); % Muestra la Imagen 1
        title('BMP de 8 bits a color') 
        subplot(1,2,2); imshow(Salida,[]); % Muestra la imagen 2
        title('BMP de 8 bits a escala de grises') 
        fclose(i1);
        
   
    end
else
    Error='Imagen no existe favor de verificar ruta'
end



