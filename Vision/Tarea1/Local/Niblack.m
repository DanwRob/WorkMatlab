
function [Salida]=Niblack(img,valor)
Salida=img;
b=str2double(valor(1))
k=str2double(valor(2))
 Kernel = ones(b)*(1/(b*b));
 Kernel_d=ones(b);
 
 Media = imfilter(img,Kernel,'replicate');
 Desviacion=stdfilt(img,Kernel_d);
 
 Umbral=double(Media)+(k*Desviacion);
 Salida(Salida > Umbral) = 255;
 Salida(Salida < Umbral) = 0;  
 imshow(Salida)