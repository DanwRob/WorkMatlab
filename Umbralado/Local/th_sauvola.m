function [ outputImage ] = th_sauvola( inputImage, k, b, R )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        inputImage=double(inputImage);
        kernelMEdias = ones(b,b);
        % kernel de medias y kernel de Standar Desviation (SD)
        kernelSD=kernelMEdias;
        
        kernelMEdias = (1/(b*b)) .* kernelMEdias;
        % aplico el filtro de medias
        IMedias = imfilter(inputImage,kernelMEdias,'replicate');
        % aplico el filtro de SD
        ISD=stdfilt(inputImage,kernelSD);
        
        ISD=(1+k.*((ISD./R)-1));
        % algoritmo de Sauvola
        umbral=IMedias.*ISD;
        outputImage=inputImage;
        outputImage(outputImage > umbral) = 255;
        outputImage(outputImage < umbral) = 0;    
end

