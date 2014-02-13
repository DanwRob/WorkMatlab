clear all; clc; close all;
addpath('./Imagenes');

img=imread('tomografia.tif');
img=mat2gray(img);
[H,W]=size(img);
S=imread('semillas.tif');

idx=find(S==255);

Q=[0.05,0.08,0.2];
miu=img(idx(1));
d=0;
n=1;
[Y,X]=find(S==255);
buffer=ones(10000,3);


while(d<Q)
    
    sum=0;
    for y=Y-1:Y+1
        for x=X-1:X+1
          if x>0 && x<=H && y>0 && y<W
                find(x==buffer(:,1))
                find(y==buffer(:,2))
             
              
          end
        end
    end

    
    
end