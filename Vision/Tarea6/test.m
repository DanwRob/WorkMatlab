% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 2 de abril 2014
% 
% Tarea No:6
% 
% Titulo: Template Matching

addpath('./Prueba1');
addpath('./Prueba3');
I=imread('texto.tif');
T=imread('letra_e.tif');
J=fftmatch(I,T,0);

I=imread('puzzlebin.tif');
T=imread('shapebin1.tif');
J=morphmatch(I,T,'white',1);
