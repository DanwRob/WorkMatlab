function [Salida,idx_t,Hist]=Ridler(img)
[Hist,N]=imhist(img);
aux=1;
A=sum(Hist);
B=sum(N.*Hist);
t=256/2;
while aux
    Miu=(sum(N(1:t).*Hist(1:t)))/(sum(Hist(1:t)));
    Vt=(B-(sum(N(1:t).*Hist(1:t))))/(A-sum(Hist(1:t)));
    t_s=(Miu+Vt)/2;
    if t==floor(t_s)
        aux=0;
    end
    t=floor(t_s);
end
idx_t=t;
 Salida=zeros(size(img));            
Salida(img>=idx_t)=255;  