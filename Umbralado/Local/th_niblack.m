function [ outputImage ] = th_niblack( inputImage, k, b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
        % genero kernel de unos
        inputImage=double(inputImage);
        kernelMEdias = ones(b,b);
        % kernel de medias y kernel de Standar Desviation (SD)
        kernelSD=kernelMEdias;
        
        kernelMEdias = (1/(b*b)) .* kernelMEdias;
        % aplico el filtro de medias
        IMedias = imfilter(inputImage,kernelMEdias,'replicate');
        % aplico el filtro de SD
        ISD=stdfilt(inputImage,kernelSD);
        % lo multiplico por k
        ISD=ISD.*k;
        % matriz de umbrales
        umbral=IMedias+ISD;
        % algoritmo de Niblack
        outputImage=inputImage;
        outputImage(outputImage > umbral) = 255;
        outputImage(outputImage < umbral) = 0;       
end

