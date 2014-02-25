clear all; clc; close all
addpath('./Sequence_02')
addpath('./Sequence_01')
fileFolder = fullfile('Sequence_01');
dirOutput = dir(fullfile(fileFolder,'*.tif'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);
fondo=imread(fileNames{1});
fondo=double(rgb2gray(fondo));
SE = strel('square',15);
figure

for i=2:numFrames
subplot(2,1,1);
I =imread(fileNames{i});
imshow(I)

subplot(2,1,2);
I=double(rgb2gray(I));
Salida=zeros(size(I));
dife=abs(I-fondo);

Salida(dife>8)=255;
%Salida = imfill(Salida,'holes');
Salida=bwareaopen(Salida,1100);

imshow(Salida,[])
pause(0.01)
end