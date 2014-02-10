clear all; close all; clc;
img=double(imread('text1.tif'));
Salida=img;
b=15;k=0.2;R=128;
 Kernel = ones(b)*(1/(b*b));
 Kernel_d=ones(b);
 
 Media = imfilter(img,Kernel,'replicate');
 Desviacion=stdfilt(img,Kernel_d);
 
 T=Media.*(1+(k*((Desviacion/R)-1)));
  Salida(Salida > T) = 255;
 Salida(Salida < T) = 0;  
 imshow(Salida)