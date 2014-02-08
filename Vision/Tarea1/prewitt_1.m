clear all; close all; clc;
img=imread('rose.tif');             %Lectura de la imagen
[I,picos]=suavizar(img);            %Funcion para suavizar el histograma...
                                     %y encontrar los picos
N=(0:255)';
valle=min(I(picos(1):picos(2)));     %Obtener valle entre los 2 picos
idx_valle=find(I==valle);               

figure
bar(N, I, 0.5);
axis([0 255 0 max(I)*1.1])
hold on
plot([picos(1) picos(1)],[0 max(I)],'r--','LineWidth',1.5);
plot([idx_valle idx_valle],[0 max(I)],'m--','LineWidth',1.5);
plot([picos(2) picos(2)],[0 max(I)],'r--','LineWidth',1.5);