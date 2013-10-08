% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 08 de Octubre 2013
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
       
       Img_pd=checkpow2(Isalida);   %Comprueba si la imagen sea de tamaño 2n, sino le añade un padding
       tic
       m_fft2=fft2_dit(Img_pd);     %Manda a llamar la funcion fft2_dit
       toc
       ifft2=ifft2_dit(m_fft2);     %Manda a llamar la funcion ifft2_dit
       m_fft2=(log(1+abs(m_fft2))); %convierte a un rango de espctro visible la dft
       
       ifft2=abs(ifft2((1:Y),(1:X)));   %Le quita el padding a la imagen
       
        figure('Name','Practica 4');
        subplot(2,2,1:2); imshow(Isalida,[]); % Muestra la Imagen original
        title('Imagen original')
        subplot(2,2,3); imshow(m_fft2,[]); % Muestra la Imagen
        title('Espectro de frecuencias de la FFT') 
        subplot(2,2,4); imshow(ifft2,[]); % Muestra la Imagen inversa de fft
        title('Inversa de la FFT') 
        
        fclose(i1);
        
   
    end
   
  

else
     disp('Imagen no existe favor de verificar ruta');
end



