function [ outputImage ] = th_wellner( inputImage, t, b )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

        inputImage=double(inputImage);
        kernelMEdias = ones(b,b);
        % kernel de medias
        kernelMEdias = (1/(b*b)) .* kernelMEdias;
        % aplico el filtro de medias
        IMedias = imfilter(inputImage,kernelMEdias,'replicate');
        umbral = IMedias.*(1-(t/100));
        outputImage=inputImage;
        outputImage(outputImage > umbral) = 255;
        outputImage(outputImage < umbral) = 0; 
end

