clear all; close all; clc;
img=double(imread('text1.tif'));
Salida=img;
b=5; t=20;
kernel = ones(b,b);
Max=ordfilt2(img,(b*b),kernel,'symmetric');
Min=ordfilt2(img,1,kernel,'symmetric');

T=(1/2)*(Min+Max);
C=Max-Min;
T(T>=img)=255;
T(T<img)=0;
C(C>t)=255;
C(C<=t)=0;

I=T&C;
I=I*255;
I=255-I;

imshow(I)