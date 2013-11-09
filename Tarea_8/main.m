% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 10 de noviembre 2013
% 
% Tarea No:7
% 
% Titulo: Tipos de Ruido
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


img = imread('board_gaussian.tif');
[m,n]=size(img);
w=ones(5,5)/25;
I2=imfilter(img,w);
figure
imshow(I2)
title('Arithmetic mean')


g=im2double(img);
f=exp(imfilter(log(g),ones(5,5),'replicate')).^(1/5/5);
figure
imshow(uint8(f*255))
title('Geometric mean')

g=im2double(img);
h=5*5./imfilter(1./(g),ones(5,5),'replicate');
figure
imshow(uint8(h*255))
title('Harmonic mean')

g=im2double(img);
c=imfilter(g.^(1.5+1),ones(5,5),'replicate')./imfilter(g.^(1.5),ones(5,5),'replicate');
figure
imshow(uint8(c*255))
title('Contraharmonic mean')

Me=ordfilt2(g,ceil(5*5/2),ones(5*5));
figure
imshow(uint8(Me*255))
title('Median')

k1=eye(5)|rot90(eye(5));
k2=zeros(5);
k2(ceil(5/2),:)=1;
k2(:,ceil(5/2))=1;
MH1=ordfilt2(g,fix(median(1:sum(sum(k1)))),ones(5*5));
MH2=ordfilt2(g,fix(median(1:sum(sum(k2)))),ones(5*5));
HB=zeros(m,n,3);
HB(:,:,1)=MH1;
HB(:,:,2)=MH2;
HB(:,:,3)=g;
figure
imshow(uint8(HB*255))
title('Hybmedian')

Me=ordfilt2(g,1,ones(5*5));
figure
imshow(uint8(Me*255))
title('Min')

Me=ordfilt2(g,5*5,ones(5*5));
figure
imshow(uint8(Me*255))
title('Max')

