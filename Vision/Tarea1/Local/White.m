function [Salida]=White(img,valor)
Salida=img;

b=str2double(valor(1));
w=str2double(valor(2));
 Kernel = ones(b)*(1/(b*b));
 Media = imfilter(img,Kernel,'replicate');
 img=img*w;
 
 Salida(Media<img)=255;
 Salida(Media>img)=0;