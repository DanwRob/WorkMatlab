function [Salida]=White(img,valor)
Salida=img;

b=str2double(valor(1));
w=str2double(valor(2));
 Kernel = ones(b)*(1/(b*b));
 %se calcula el valor medio con un vecindario
 Media = imfilter(img,Kernel,'replicate');
 img=img*w;
 %asignacion del pixel con respecto a la media.
 Salida(Media<img)=255;
 Salida(Media>img)=0;