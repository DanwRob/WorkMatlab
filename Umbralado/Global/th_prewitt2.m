function [ t ] = th_prewitt2( inputImage )
%Prewitt2 Funcion para calcular la segmentacion global de una imagen
%   Este metodo (Prewitt2) primero obtiene los picos maximos del histograma
%   y despues calcula el promedio de estos maximos locales.
H=imhist(inputImage);  %Obtengo el histograma de la imagen
count=0;
max=0;
min=0;
while count~=2
for y=2:254
    H(y)=(H(y-1)+H(y)+H(y+1))/3;
end
count=0;
for y=2:254
    if H(y)>H(y-1) && H(y)>H(y+1)
        count = count + 1;
        if(count==1)
            min=y;
        else
            max=y;            
        end
    end
end
end
t=ceil((min+max))/2;
% inputImage(inputImage<t)=0;
% inputImage(inputImage>=t)=255;
% outputImage = inputImage;
end

