clear all
close all
clc
addpath('./Codigos');
 
I=imread('Imagenes/text1.tif');
I=double(I);
%I=imresize(I, 0.5);
 
 
Min=min(I(:));
Max=max(I(:));
 
n=256;
 
w=5;
T1=20;
T2=20;
T3=200;
T4=T3;
 
%expancion de rango dinamico
I1=255*((I-Min)/(Max-Min));
 
figure
imshow(I1)
 
[Y X]=size(I)
 
 
 
%suavizado
H=[1 1 1;1 0 1; 1 1 1];
 
mn=ordfilt2(I1,1,H);
mx=ordfilt2(I1,8,H);
r=(mx)-(mn);
I2=imfilter(I1,H/8);
 
 
F=find(r>T1);
I2(F)=I1(F);
 
 
figure
imshow(I2,[])
 
 
%umbralado adaptativo y expansion del rango dinamico
 
Kernel=ones(w);
 
Max=ordfilt2(I2,9,Kernel);
Min=ordfilt2(I2,1,Kernel);
mb=imfilter(I2,(Kernel/(w^2)));
 
 
aux=(Max-Min);
 
XXX=1;
 
 
I3=ones(size(I)).*(255.*( (I2-Min) ./ (mb-Min) ));
%I3=ones(size(I))*255;
if XXX==1
 
    
    F= unique([find(aux <T2); find(I2>=mb)]);
 
   % for i=1:length(F)
   %     Fi=F(i);
   %     I3(Fi)=255*( (I2(Fi)-Min(Fi)) / (mb(Fi)-Min(Fi)) );
   % end
 
  I3(F)=255;
  
else
    
    for j=1:Y
        for i=1:X 
            if( (((Max(j,i)-Min(j,i)) <T2) || (I2(j,i)>=mb(j,i)) ))
                I3(j,i)=255;
                
                %I3(j,i)=255*( (I2(j,i)-Min(j,i)) ./ (mb(j,i)-Min(j,i)) );
            end
        end
    end
    
end
figure
imshow(I3,[])
 
 
 
 
%segmentacion
 
 
I4=zeros(size(I));
H=ones(3);
 
 
 
 
 
Min=ordfilt2(I3,1,H);
 
m=imfilter(I3,(H/9));
sumatoria=imfilter(  ((I3.^2)-m.^2) ,H);
S=sqrt(sumatoria)/3;
 
F=find(Min<T3);
F2=find(S>T4);
I4(F)=1;
I4(F2)=1;
 
figure
imshow(~I4,[])