function [I_s] = segmotion(fondo,actual,T,Area,SE) 
actual=double(rgb2gray(actual));    
I_s=zeros(size(actual));        %se crea matriz de salida
dife=abs(actual-fondo);         %se calcula la diferencia entre el fondo y la imagen actual
I_s(dife>T)=255;                %se asigna 255 a las diferencias que sobrepasen el umbral t
I_s=imopen(I_s,SE);             %se aplica una apertura cun un elemnto estructurante cuadrado para reducir ruido
I_s=bwareaopen(I_s,Area);       %Se aplica una apertura para quitar elementos que no sobrepasen una determinada Area
I_s = imfill(I_s,'holes');      %rellena huecos