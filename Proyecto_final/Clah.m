function [CEImage] = Clah(Image,NrX,NrY,Cliplimit)
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
size(CEImage)

for i=1:NrY
    for j=1:NrX
        aux=histequal(CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize),Cliplimit);
        CEImage(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize)=aux;
    end
end
yI=1;
for i = 1:NrY+1
    if i == 1
        subY = YSize/2;
        
    elseif i == NrY+1
        subY = YSize/2;
        
    else
        subY = YSize;
        
    end
    xI = 1;
    for j = 1:NrX+1
        if j == 1
            subX = XSize/2;
           
        elseif j == NrX+1
            subX = XSize/2;
           
        else
            subX = XSize;
            
        end 
        
            subImagen=zeros(subY,subX);
            subImagen= CEImage(yI:yI+subY-1,xI:xI+subX-1);
            for k = 0:subY-1
                y=k/(subY-1);
                for m = 0:subX-1
                    x=m/(subX-1);
                       
                        subImagen(k+1,l+1) = fix(( ((1-x)*(1-y)*(CEImage(yI,xI))) +...
                        (x*(1-y)*CEImage(yI,xI+subX-1))+...
                       ((1-x)*y*CEImage(yI+subY-1,xI))+...
                        (x*y*CEImage(yI+subY-1,xI+subX-1))));

                end
            end
            %subImage = interpolate(subImage,UL,UR,BL,BR,subX,subY);
            CEImage(yI:yI+subY-1,xI:xI+subX-1) = subImagen;
        
        
        xI = xI + subX;
    end
    yI = yI + subY;
   
end

