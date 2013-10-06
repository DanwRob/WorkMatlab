% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 02 de Octubre 2013
% 
% Tarea No:4
% 
% Titulo: Seguimiento del contorno de objetos múltiples
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('new.bmp','r');         % Se abre la imagen con fopen y con permisos de lectura

if(i1~=-1)
    
   [Isalida,flag]=readbmp(i1);     %llama a la funcion readbmp, le pasa el valor si encuentra los archivo
    
   g=[0,255,0,255,0]
       
  
   
  
   Isalida=checkpow2(g);
 
   y=fft(Isalida)
   fft_dit(Isalida)

else
    Error='Imagen no existe favor de verificar ruta'
end



