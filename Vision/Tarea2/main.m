% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 15 de Febrero 2014
% 
% Tarea No:2
% 
% Titulo: Segmentacion basada en crecimiento de region
% 
% ------------------------------------------------------------------------



clear all; clc; close all;
addpath('./Imagenes');

img=imread('tomografia.tif');   %Imagen de entrada
S=imread('semillas.tif');       %Semillas a usar

Q=[0.05, 0.08, 0.2];            %Predicados de cada region

[I,Iq]=regrow(img,S,Q,1);       %llamar el metodo regrow


%Mostrar objetos segmentados
figure;
subplot 221; imshow(img); title('Imagen Original');
subplot 222; imshow(Iq(:,:,1),[]); title('Region 1');
subplot 223; imshow(Iq(:,:,2),[]); title('Region 2');
subplot 224; imshow(Iq(:,:,3),[]); title('Region 3');
figure;
imshow(label2rgb(I)); title('Imagen segmentada y etiquetada');