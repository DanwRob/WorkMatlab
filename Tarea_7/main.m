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


img = imread('cameraman.tif');       %Lee imagen
I=mat2gray(img);   

Resultado=imnoises(I,'uniform',0,0.5);  %Manda a llamar ruido uniform
figure
imshow(Resultado)
title('uniforme')

Resultado=imnoises(I,'gaussian',0,0.3); %Manda a llamar Ruido gaussian
figure
imshow(Resultado)
title('gausiano')

Resultado=imnoises(I,'lognormal',0,0.1);    %Manda a llamar lognormal
figure
imshow(Resultado)
title('lognormal')

Resultado=imnoises(I,'rayleigh',0,0.1);     %Manda a llamar rayleigh
figure
imshow(Resultado)
title('raylengt')

Resultado=imnoises(I,'exponential',5,[]);   %Manda a llamar exponential
figure
imshow(Resultado)
title('exponencial')

Resultado=imnoises(I,'erlang',5,10);        %Manda a llamar erlang
figure
imshow(Resultado)
title('erlang')

Resultado=imnoises(I,'salt&pepper',0.05,0.05);  %Manda a llamar Salt&Pepper
if Resultado~=-1
figure
imshow(Resultado)
title('sal & pimienta')
end
