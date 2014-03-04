clear all; clc; close all
addpath('./Sequence_02')
addpath('./Sequence_01')
fileFolder = fullfile('Sequence_01');
dirOutput = dir(fullfile(fileFolder,'*.tif'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);
fondo=imread(fileNames{1});
fondo=double(rgb2gray(fondo));
SC = strel('square',2);
SE = strel('disk',2);
figure

for i=2:numFrames
subplot(2,1,1);
I =imread(fileNames{i});
imshow(I)

subplot(2,1,2);
I=double(rgb2gray(I));
Salida=zeros(size(I));
dife=abs(I-fondo);

Salida(dife>4)=255;
Salida=imopen(Salida,SC);
Salida=bwareaopen(Salida,1100);
Salida = imfill(Salida,'holes');
imshow(Salida,[]); hold on;
if i>20
    [B,~] = bwboundaries(Salida,'noholes'); 
    for k = 1:length(B)
        boundary = B{k};
    end
    plot(boundary(:,2), boundary(:,1), 'y','LineWidth', 2);
    clear B;
    hold off;
end
pause(0.01)
end