% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 02 de Octubre 2013
% 
% Tarea No:2
% 
% Titulo: Practica 2.1: Seguimiento de contornos
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('b.bmp','r');% Se abre la imagen con fopen y con permisos de lectura
if(i1~=-1)
    
    [Isalida,flag]=readbmp(i1);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
    Salida=bwedge(Isalida); % se pasa la imagen al metodo para detectar bordes
    if(flag~=0)
        
        figure('Name','Practica 2.1: Seguimiento de contornos');
        subplot(1,2,1); imshow(Isalida,[]); % Muestra la Imagen 1
        title('Imagen original') 
        subplot(1,2,2); imshow(Salida,[]); % Muestra la imagen 2
        title('Seguimiento de contorno con 4 adyaciencia') 
        fclose(i1);
        
   
    end
else
    Error='Imagen no existe favor de verificar ruta'
end



