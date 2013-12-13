function [CEImage] = Clah(Image,NrX,NrY,NrBins,Cliplimit)
[YRes,XRes]=size(Image);
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


if(mod(YRes,NrY)~=0)
  pad_Y=NrY-mod(YRes,NrY);
else
 pad_Y=0;
end
if(mod(XRes,NrX)~=0)
  pad_X=NrX-mod(XRes,NrX);
else
    pad_X=0;
end
CEImage = zeros(YRes+pad_Y,XRes+pad_X);
CEImage(1:YRes,1:XRes)=Image;
size(CEImage)

for i=1:NrY
    for j=1:NrX
        aux=histequal(CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize),Cliplimit);
        CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize)=aux;
    end
end

