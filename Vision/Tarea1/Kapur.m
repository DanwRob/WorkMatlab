clear all; close all; clc;
img=imread('cameraman.tif');
[Hist,N]=imhist(img);

Probabilidades=Hist/sum(Hist);
Ps=zeros(256,1);
Hs=zeros(256,1);
Hn=-1*(Probabilidades.*log(Probabilidades));
Hn(isnan(Hn))=0;

for x=1:256
    Ps(x)=sum(Probabilidades(1:x));
end

for x=1:256    
   Hs(x)=sum(Hn(1:x));
end
Hn=sum(Hn);
Ha=log(Ps)+(Hs./Ps);
Hb=log(1-Ps)+((Hn-Hs)./(1-Ps));
entropia=Ha+Hb;
t=max(entropia);
idx_t=find(entropia==t,1);
