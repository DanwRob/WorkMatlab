% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 02 de Octubre 2013
% 
% Tarea No:4
% 
% Titulo: Transformada de Fourier Directa y Rapida
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar



i1 = fopen('MRI.bmp','r');         % Se abre la imagen con fopen y con permisos de lectura

if(i1~=-1)
       
   [Isalida,flag]=readbmp(i1);     %llama a la funcion readbmp, le pasa el valor si encuentra los archivo
   if(flag~=0)
   
       [Y,X]=size(Isalida);
       Isalida=double(Isalida);
       tic
       m_dft2= dft2(Isalida);               %Llama a la funcion dft2
       toc
       m_idft2=abs(idft2(m_dft2));                %Llama a la funcion idft2

       m_dft2=(log(1+abs(m_dft2)));          %Conveirte a un rango de espctro visible la dft
       
        figure('Name','Practica 4');
        subplot(2,2,1:2); imshow(Isalida,[]); % Muestra la Imagen original
        title('Imagen original')
        subplot(2,2,3); imshow(m_dft2,[]); % Muestra la Imagen
        title('Espectro de frecuencias de la DFT') 
        subplot(2,2,4); imshow( m_idft2,[]); % Muestra la Imagen inversa de dft
        title('Inversa de la DFT') 
        
        fclose(i1);
   
    end
   
  

else
     disp('Imagen no existe favor de verificar ruta');
end



