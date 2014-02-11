function [Salida,idx_t,Hist]=Otsu(img)
[Hist,N]=imhist(img);

A=sum(Hist);
B=sum(N.*Hist);
Miu=zeros(256,1);
Vt=zeros(256,1);
Aj=zeros(256,1);
varianza=zeros(256,1);

for x=1:256
    Miu(x)=(sum(N(1:x).*Hist(1:x)))/(sum(Hist(1:x)));
    Vt(x)=(B-(sum(N(1:x).*Hist(1:x))))/(A-sum(Hist(1:x)));
    Aj(x)=sum(Hist(1:x));
end
varianza=(Aj.*(A-Aj)).*((Miu-Vt).^2);
t=max(varianza);
idx_t=find(varianza==t,1);
 Salida=zeros(size(img));            
Salida(img>=idx_t)=255;   