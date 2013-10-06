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



i1 = fopen('huella.bmp','r');         % Se abre la imagen con fopen y con permisos de lectura

if(i1~=-1)
    
    [Isalida,flag]=readbmp(i1);     %llama a la funcion readbmp, le pasa el valor si encuentra los archivo
  
   y=fft2(Isalida);
   x = dft2(Isalida);
   inversa=idft2(x);
   f=abs(x);
    
   final=(log(1+f));
        
  
    if(flag~=0)
        
        figure('Name','Practica 4');
        subplot(2,2,1); imshow(Isalida,[]); % Muestra la Imagen 1
        title('Imagen original') 
        subplot(2,2,2); imshow(f,[]); % Muestra la Imagen 1
        title('Imagen original')
        subplot(2,2,3); imshow(final,[]); % Muestra la Imagen 1
        title('Imagen original') 
        subplot(2,2,4); imshow( abs(inversa),[]); % Muestra la Imagen 1
        title('Imagen original') 
        
        
        fclose(i1);
        
   
    end
   
else
    Error='Imagen no existe favor de verificar ruta'
end



