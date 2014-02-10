clear all; close all; clc;
img=imread('rose.tif');
[Hist,N]=imhist(img);
A=sum(Hist);
B=sum(N.*Hist);
Er=sum(Hist);

for x=1:256
    E1=0;
    E2=0;
    At=(sum(Hist(1:x)));
    Bt=(sum(N(1:x).*Hist(1:x)));
    Miu=Bt/At;
    Vt=(B-Bt)/(A-At);
    
    for j=1:x
        E1=E1+((j-Miu)^2);
    end
    for k=x+1:256
        E2=E2+((k-Vt)^2);
    end
    
    
    Er(x)=E1+E2;
end
 Er(isinf(Er))=NaN;
 Er(isnan(Er))=max(Er);
 t=min(Er)
 idx_t=find(Er==t,1);