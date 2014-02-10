function [ outputImage ] = th_white( inputImage, w, b )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
        inputImage=double(inputImage);
        kernelMedias = ones(b,b);
        % kernel de medias
        kernelMedias = (1/(b*b)) .* kernelMedias;
        % aplico el filtro de medias
        IMedias = imfilter(inputImage,kernelMedias,'replicate');
        inputImage=inputImage.*w;
        IMedias(IMedias < inputImage)=0;
        IMedias(IMedias > inputImage)=255;
        
        outputImage=IMedias;
        outputImage=255-outputImage;
        
end

