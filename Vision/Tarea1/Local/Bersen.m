function [Salida]=Bersen(img,valor)

b=str2double(valor(1)); t=str2double(valor(2));
kernel = ones(b,b);
Max=ordfilt2(img,(b*b),kernel,'symmetric');
Min=ordfilt2(img,1,kernel,'symmetric');
%calculo del umbral T
T=(1/2)*(Min+Max);
%calculo del contraste C
C=Max-Min;
%asignacion de niveles de gris para T y C
T(T>=img)=255;
T(T<img)=0;
C(C>t)=255;
C(C<=t)=0;
%interseccion entres T y C
Salida=T&C;
Salida=Salida*255;
Salida=255-Salida;
