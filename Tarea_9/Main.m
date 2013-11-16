% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 10 de noviembre 2013
% 
% Tarea No:8.1
% 
% Titulo: Filtrados
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar


I =double (imread('patterns.bmp'));
[Y,X]=size(I);

[M,N]=meshgrid(0:Y-1,0:X-1);
J=I.*((-1).^(M+N));
J=fft2(J);
%J=log(1*abs(J));
 
X2=X/2;
Y2=Y/2;

[V,U]=meshgrid(-Y2:Y2-1,-X2:X2-1);
D=sqrt(U.^2+V.^2);
n=2;
D0=35;

H=1./(1+(D/D0).^(2*n));

H=1-H;

HP=H.*J;%%%%%%%%%%pasa alta
Hp=abs(ifft2(HP));
imshow(Hp,[]);



