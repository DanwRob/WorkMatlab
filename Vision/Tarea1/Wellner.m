clear all; close all; clc;
img=double(imread('text1.tif'));
Salida=img;
b=15;k=15;
Kernel = ones(b)*(1/(b*b));
 
 Media = imfilter(img,Kernel,'replicate');
 img=img*k;
 Salida(Salida > T) = 255;
 Salida(Salida < T) = 0;  
 imshow(Salida)