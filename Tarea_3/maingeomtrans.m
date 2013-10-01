% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 30 de Septiembre 2013
% 
% Tarea No:3
% 
% Titulo: Transformaciones Geometricas
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('letra_k.bmp','r');% Se abre la imagen con fopen y con permisos de lectura
if(i1~=-1)
    
    [Isalida,flag]=readbmp(i1);%llama a la funcion readbmp, le pasa el valor si encuentra los archivo
   
    [Salida,interSalida]=geomtrans(Isalida,'RTS',{'-30';'12 13';'2 2'});%llama la funcion para aplicar las transformaciones
    
    
    if(flag~=0)
        
        figure('Name','Practica 2: Tranformadas Geometricas');
        subplot(2,2,1); imagesc(Isalida); colormap(gray); % Muestra la Imagen Original
        title('Imagen Original') 
        subplot(2,2,3); imagesc(Salida); colormap(gray); % Muestra la Imagen Tranformada
        title('Imagen Transformada') 
        subplot(2,2,4); imagesc(interSalida); colormap(gray);  % Muestra la imagen Interpolada
        title('Imagen Interpolada') 
        fclose(i1);
        
   
    end
else
    disp('Imagen no existe favor de verificar ruta');
   
end
