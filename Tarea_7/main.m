% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 16 de octubre 2013
% 
% Tarea No:6
% 
% Titulo: Ecualización global del histograma
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar

a=0;
b=0.3;
img = imread('cameraman.tif');

uniforme =mat2gray(img);
U = rand(size(img));
z=(a+(b-a))*U;

figure
imshow(uniforme+(z))


a=0;
b=0.1;
N = randn(size(img));
z=a+(b-a)*N;

figure
imshow(uniforme+z)



a=0;
b=0.1;
N = randn(size(img));

z = exp(b*N + a);
z=mat2gray(uniforme+z);
figure
imshow(z)


a=0;
b=0.1;
U = rand(size(img));
z = a+sqrt(-b*log(1-U));
figure
imshow(uniforme+z)


a=5;
U = rand(size(img));
z = (-1/a)*(log(1-U));
figure
imshow(uniforme+z)


a=0.5;
b=0.5;
U = rand(size(img));
z = U;
figure
imshow(uniforme+z)

