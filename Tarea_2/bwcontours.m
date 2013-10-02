% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 02 de Octubre 2013
% 
% Tarea No:2.3
% 
% Titulo: Seguimiento del contorno de objetos múltiples
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('new4.bmp','r');         % Se abre la imagen con fopen y con permisos de lectura
if(i1~=-1)
    
    [Isalida,flag]=readbmp(i1);     %llama a la funcion readbmp, le pasa el valor si encuentra los archivo
   
    Salida=bwlabeling(Isalida);     % Se de etiquetado de regiones conexas
    Salida2=bwedge(Salida);         %Se pasa la salida de la funcion etiquetado y se buscan los bordes de todos los objetos encontrados
    
    if(flag~=0)
        
        figure('Name','Practica 2.3: Seguimiento del contorno de objetos múltiples');
        subplot(1,2,1); imshow(Isalida,[]); % Muestra la Imagen 1
        title('Imagen original') 
        subplot(1,2,2); imshow(Salida2,[]); % Muestra la imagen 2
        title('Contorno de objetos múltiples') 
        fclose(i1);
        
   
    end
else
    Error='Imagen no existe favor de verificar ruta'
end



