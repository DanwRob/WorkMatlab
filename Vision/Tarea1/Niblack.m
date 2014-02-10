
clear all; close all; clc;
img=double(imread('text1.tif'));
Salida=img;
b=15;k=-0.2;
 Kernel = ones(b)*(1/(b*b));
 Kernel_d=ones(b);
 
 Media = imfilter(img,Kernel,'replicate');
 Desviacion=stdfilt(img,Kernel_d);
 
 Umbral=Media+(k*Desviacion);
 Salida(Salida > Umbral) = 255;
 Salida(Salida < Umbral) = 0;  
 imshow(Salida)