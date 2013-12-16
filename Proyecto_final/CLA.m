function [CEImage] = CLA(Image,NrX,NrY,Cliplimit)
[YRes,XRes]=size(Image);
CEImage = zeros(YRes,XRes);

if Cliplimit == 1
    return
end

XSize = round(XRes/NrX);
YSize = round(YRes/NrY);



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

for i=1:NrY
    for j=1:NrX
        aux=histequal(CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize),Cliplimit);
        CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize)=aux;
    end
end
[YRes,XRes]=size(CEImage);
Salida=zeros(YRes+2,XRes+2);
Salida(1,2:XRes+1)=CEImage(1,:);
Salida(YRes+2,2:XRes+1)=CEImage(YRes,:);
Salida(2:YRes+1,2:XRes+1)=CEImage;
Salida(:,1)=Salida(:,2);
Salida(:,end)=Salida(:,end-1);
for y=2:YRes
    for x=2:XRes
        CEImage(y-1,x-1)=(Salida(y-1,x-1)+Salida(y-1,x+1)+Salida(y+1,x-1)+Salida(y+1,x+1))/4;
    end
end



