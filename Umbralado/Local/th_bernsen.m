function [ outputImage ] = th_bernsen( inputImage, t, b)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

        %genero kernel
        kernel = ones(b,b); 
        %convolucion y tomando el valor maximo
        Max=ordfilt2(inputImage,(b*b),kernel,'symmetric');
        Min=ordfilt2(inputImage,1,kernel,'symmetric');
        umbral=Max/2 + Min/2;  
        contraste=Max-Min;
        imshow(contraste);
        umbral(umbral>=inputImage)=255;
        umbral(umbral<inputImage)=0;
        contraste(contraste>t)=255;
        contraste(contraste<t)=0;
        I=umbral&contraste;
        I=I*255;
        I=255-I;
        outputImage=I;
        

end

