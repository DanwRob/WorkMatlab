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



img=double(imread('pollen_dark.tif'));      %Se lee la imagen y se transforma a double
   
[Salida,cdf]=histequal(img);                %Se llama la funcion para ecualizacion del histograma




