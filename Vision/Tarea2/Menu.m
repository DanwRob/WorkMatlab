addpath('./Sequence_02')
addpath('./Sequence_01')
fileFolder = fullfile('Sequence_02');
dirOutput = dir(fullfile(fileFolder,'*.tif'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);
fondo=imread(fileNames{1});
fondo=rgb2gray(fondo);
SE = strel('square',15);
figure
for i=2:numFrames
name=fileNames{1};
subplot(2,1,1);
I =imread(name);
imshow(I)
subplot(2,1,2);
I=rgb2gray(I);
Salida=uint8(zeros(size(I)));
dife=abs(I-fondo);
idx=find(dife>4);
Salida(idx)=255;
%Salida=imfill(Salida,'holes'); 
%imgMarcador=imerode(Salida,SE);
%Salida=imreconstruct(imgMarcador,I); 
imshow(Salida,[])
pause(0.01)
end