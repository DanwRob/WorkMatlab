function [Salida]=Wellner(img,valor)
Salida=img;
b=str2double(valor(2));t=str2double(valor(1));
Kernel = ones(b)*(1/(b*b));
 
 Media = imfilter(img,Kernel,'replicate');
 
umbral=Media.*(1-(t/100)); 
Salida(Salida > umbral) = 255;
 Salida(Salida < umbral) = 0;  