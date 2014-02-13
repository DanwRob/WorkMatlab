function [Salida]=Sauvola(img,valor)
Salida=img;
b=str2double(valor(1));k=str2double(valor(2));R=str2double(valor(3));
 Kernel = ones(b)*(1/(b*b));
 Kernel_d=ones(b);
  %calculo de media y desviasion esgt�ndar
 Media = imfilter(img,Kernel,'replicate');
 Desviacion=stdfilt(img,Kernel_d);
 %calculo del umbral
 T=double(Media).*(1+(k*((Desviacion/R)-1)));
  Salida(Salida > T) = 255;
 Salida(Salida < T) = 0;  
 