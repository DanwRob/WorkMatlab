% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 14 de octubre 2013
% 
% Tarea No:5
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------


clear all; clc; close all; %Limpia todo antes de empezar

%Transformacion lineal

    figure('Name','Practica 5: Transformacion lineal');
    img=double(imread('cameraman.tif'));   %Se lee la imagen y se transforma a double
    
    Salida=imgraytrans(img,'lin',{'1.5 0'});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,1:2); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original') 
    
    subplot(2,2,3); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformada a=1.5')
    
    Salida=imgraytrans(img,'lin',{'1 -80'});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,4); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformada con b=-20') 
       
    
    
    
  %Transformacion negativo

    figure('Name','Practica 5: Transformacion negativo');
    img=double(imread('pet.tif'));   %Se lee la imagen y se transforma a double
    
    Salida=imgraytrans(img,'neg',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,1); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original') 
    
    subplot(2,2,2); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformada negativa')
    
    img=double(imread('breast.tif'));
    Salida=imgraytrans(img,'neg',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,3); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original')
   
    Salida=imgraytrans(img,'neg',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,4); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Normalizada') 
    
    
  %Transformacion Logaritmica
    figure('Name','Practica 5: Transformacion Logaritmica');
    img=double(imread('spine.tif'));   %Se lee la imagen y se transforma a double
    Salida=imgraytrans(img,'log',{'0.5'});%llama la funcion para aplicar las Transformaciones de intesidad
    
    subplot(1,2,1); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original') 
    subplot(1,2,2); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformada o=0.5')
    
    
    
    
  %Transformacion Gamma
    figure('Name','Practica 5: Transformacion Gamma');
    img=double(imread('aerial.tif'));   %Se lee la imagen y se transforma a double
    Salida=imgraytrans(img,'gamma',{'1 2'});%llama la funcion para aplicar las Transformaciones de intesidad
  
    subplot(2,2,1); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original') 
    subplot(2,2,2); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformacion Gamma y=2')
  
    Salida=imgraytrans(img,'gamma',{'1 3'});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,3); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformacion Gamma y=3')
   
    Salida=imgraytrans(img,'gamma',{'1 4'});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,4); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Transformacion Gamma y=4') 
    
    
    
    
   %Transformacion de Normalizacion
    figure('Name','Practica 5: Transformacion de Normalizacion');
    img=double(imread('einstein.tif'));   %Se lee la imagen y se transforma a double
    
    Salida=imgraytrans(img,'norm',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,1); imshow(uint8(img)); % Muestra la Imagen Original
    title('Imagen Original') 
    
    subplot(2,2,2); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Normalizada')
    
    img=double(imread('polen.tif'));
    Salida=imgraytrans(img,'norm',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,3); imshow(uint8(img)); % Muestra la Imagen original
    title('Imagen Original')
   
    Salida=imgraytrans(img,'norm',{''});%llama la funcion para aplicar las Transformaciones de intesidad
    subplot(2,2,4); imshow(Salida); % Muestra la Imagen Tranformada
    title('Imagen Normalizada') 
  
        
      
        
 
      