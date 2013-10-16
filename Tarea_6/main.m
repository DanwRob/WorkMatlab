% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 16 de octubre 2013
% 
% Tarea No:6
% 
% Titulo: Ecualización global del histograma
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar

figure;

img=double(imread('pollen_dark.tif'));      %Se lee la imagen y se transforma a double
   
[Salida,cdf]=histequal(img);                %Se llama la funcion para ecualizacion del histograma

subplot(4,5,1);                             
imshow(uint8(img));
title('Imagen Original')                    %imagen original
subplot(4,5,2);
imshow(Salida);                             %imagen Mejorada
title('Imagen Mejorada') 

subplot(4,5,3);
histo_original=imhistogram(img);            
N=numel(uint8(img));                        %PDF Original
pdf=histo_original.*N^(-1);
bar(0: 255, pdf, 'b');
axis([0 255 0 max(pdf)])
title('PDF Original') 

subplot(4,5,4);
plot(0: 255, cdf, 'b','LineWidth',2);       %CDF
axis([0 255 0 max(cdf)])
grid on
title('CDF') 

subplot(4,5,5);
histo_nuevo=imhistogram(Salida);            %PDF Mejorada
N=numel(Salida);
pdf_nuevo=histo_nuevo.*N^-1;
bar(0: 255, pdf_nuevo, 'b');
axis([0 255 0 max(pdf_nuevo)])
title('PDF Mejorada') 



img=double(imread('pollen_bright.tif'));   %Se lee la imagen y se transforma a double

[Salida,cdf]=histequal(img);                %Se llama la funcion para ecualizacion del histograma

subplot(4,5,6);
imshow(uint8(img));                         %imagen original
title('Imagen Original') 
subplot(4,5,7);
imshow(Salida);
title('Imagen Mejorada')                    %imagen Mejorada

subplot(4,5,8);
histo_original=imhistogram(img);
N=numel(uint8(img));
pdf=histo_original.*N^(-1);
bar(0: 255, pdf, 'b');
axis([0 255 0 max(pdf)])
title('PDF Original') 

subplot(4,5,9);
plot(0: 255, cdf, 'b','LineWidth',2);
axis([0 255 0 max(cdf)])
grid on
title('CDF') 

subplot(4,5,10);
histo_nuevo=imhistogram(Salida);
N=numel(Salida);
pdf_nuevo=histo_nuevo.*N^-1;
bar(0: 255, pdf_nuevo, 'b');
axis([0 255 0 max(pdf_nuevo)])
title('PDF Mejorada') 




img=double(imread('pollen_low.tif'));   %Se lee la imagen y se transforma a double
   
[Salida,cdf]=histequal(img);            %Se llama la funcion para ecualizacion del histograma

subplot(4,5,11);
imshow(uint8(img));
title('Imagen Original')                %imagen original
subplot(4,5,12);
imshow(Salida);
title('Imagen Mejorada')                %imagen Mejorada

subplot(4,5,13);
histo_original=imhistogram(img);
N=numel(uint8(img));
pdf=histo_original.*N^(-1);
bar(0: 255, pdf, 'b');
axis([0 255 0 max(pdf)])
title('PDF Original') 

subplot(4,5,14);
plot(0: 255, cdf, 'b','LineWidth',2);
axis([0 255 0 max(cdf)])
grid on
title('CDF') 

subplot(4,5,15);
histo_nuevo=imhistogram(Salida);
N=numel(Salida);
pdf_nuevo=histo_nuevo.*N^-1;
bar(0: 255, pdf_nuevo, 'b');
axis([0 255 0 max(pdf_nuevo)])
title('PDF Mejorada') 


img=double(imread('pollen_high.tif'));   %Se lee la imagen y se transforma a double
   
[Salida,cdf]=histequal(img);            %Se llama la funcion para ecualizacion del histograma

subplot(4,5,16);
imshow(uint8(img));
title('Imagen Original')                %Imagen Original
subplot(4,5,17);                        
imshow(Salida);
title('Imagen Mejorada')                %Imagen Mejorada

subplot(4,5,18);
histo_original=imhistogram(img);
N=numel(uint8(img));                     %PDF Original
pdf=histo_original.*N^(-1);
bar(0: 255, pdf, 'b');
axis([0 255 0 max(pdf)])
title('PDF Original') 

subplot(4,5,19);
plot(0: 255, cdf, 'b','LineWidth',2);    %CDF
axis([0 255 0 max(cdf)])
grid on
title('CDF') 

subplot(4,5,20);
histo_nuevo=imhistogram(Salida);
N=numel(Salida);
pdf_nuevo=histo_nuevo.*N^-1;             %PDF Mejorada
bar(0: 255, pdf_nuevo, 'b');
axis([0 255 0 max(pdf_nuevo)])
title('PDF Mejorada') 


