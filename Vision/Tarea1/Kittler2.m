
clear all; close all; clc;
img=imread('rose.tif');
[Hist,N]=imhist(img);
t=256/2;
aux=1;
A=sum(Hist);
B=sum(N.*Hist);
C=sum((N.^2).*Hist);

media=zeros(256,1);
Varianza=zeros(256,1);
while aux
    Ct=sum((N(1:t).^2).*Hist(1:t));
    At=(sum(Hist(1:t)));
    Bt=(sum(N(1:t).*Hist(1:t)));
    pt=At/A;
    qt=(A-At)/A;
    Miu=Bt/At;
    Vt=(B-Bt)/(A-At);
    Varianza=(Ct/At)-Miu^2;
    media=((C-Ct)/(A-At))-Vt^2;
   omega=(1/Varianza)-(1/media);
   omega2=(Miu/Varianza)-(Vt/media);
   omega3=((Miu^2/Varianza)-(Vt^2/media))+log((Varianza*qt^2)/(media*pt^2));
   t_s=(omega2+sqrt(omega2^2-(omega*omega3)))/(omega);
   if t==floor(t_s)
       aux=0;
   end
   t=floor(t_s)
end
   