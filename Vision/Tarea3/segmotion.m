function [I_s] = segmotion(fondo,actual,T,Area,SE) 
actual=double(rgb2gray(actual));
I_s=zeros(size(actual));
dife=abs(actual-fondo);
I_s(dife>T)=255;
I_s=imopen(I_s,SE);
I_s=bwareaopen(I_s,Area);
I_s = imfill(I_s,'holes');