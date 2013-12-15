function [CEImage] = CLAHE(Image,NrX,NrY,NrBins,Cliplimit)
[XRes,YRes]=size(Image);
Min=min(Image(:));
Max=max(Image(:));
CEImage = zeros(YRes,XRes);
if Cliplimit == 1
    return
end

NrBins=max(NrBins,128);
XSize = round(XRes/NrX);
YSize = round(YRes/NrY);
NrPixels = XSize*YSize;
XSize2 = round(XSize/2);
YSize2 = round(YSize/2);

if Cliplimit > 0 
    ClipLimit = max(1,Cliplimit*XSize*YSize/NrBins);
else
    ClipLimit = 1E8;
end

LUT=makeLUT(Min,Max,NrBins);

Bin=1+LUT(round(Image));
Hist = makeHistogram(Bin,XSize,YSize,NrX,NrY,NrBins);
if Cliplimit > 0
    Hist = clipHistogram(Hist,NrBins,ClipLimit,NrX,NrY);
end
Map=mapHistogram(Hist,Min,Max,NrBins,NrPixels,NrX,NrY);
% Interpolate
xI = 1;
for i = 1:NrX+1
    if i == 1
        subX = XSize/2;
        xU = 1;
        xB = 1;
    elseif i == NrX+1
        subX = XSize/2;
        xU = NrX;
        xB = NrX;
    else
        subX = XSize;
        xU = i - 1;
        xB = i;
    end
    yI = 1;
    for j = 1:NrY+1
        if j == 1
            subY = YSize/2;
            yL = 1;
            yR = 1;
        elseif j == NrY+1
            subY = YSize/2;
            yL = NrY;
            yR = NrY;
        else
            subY = YSize;
            yL = j - 1;
            yR = j;
        end
        UL = Map(xU,yL,:);
        UR = Map(xU,yR,:);
        BL = Map(xB,yL,:);
        BR = Map(xB,yR,:);
        subImage = Bin(xI:xI+subX-1,yI:yI+subY-1);
        subImage = interpolate(subImage,UL,UR,BL,BR,subX,subY);
        CEImage(xI:xI+subX-1,yI:yI+subY-1) = subImage;
        yI = yI + subY;
    end
    xI = xI + subX;
   
end