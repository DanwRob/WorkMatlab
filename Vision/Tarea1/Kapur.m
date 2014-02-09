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
temp=0;
for x=1:256
    for y=1:x
        temp=-1*(Probabilidades(y).*log(Probabilidades(y)));
        if(isnan(temp))
            temp=0;
        end
        temp=temp+temp;
    end
    Hs(isnan(Hs))=0;
end
Hs(isnan(Hs))=0;

Ha=log(Ps)+(Hs./Ps);
Hb=log(1-Ps)+((Hn-Hs)./(1-Ps));

t=Ha+Hb;