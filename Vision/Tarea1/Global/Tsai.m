function [Salida,idx_t,Hist]=Tsai(img)
[Hist,N]=imhist(img);


bar(N,Hist)
At=zeros(256,1);
A=sum(Hist);
for x=1:256
     At(x)=sum(Hist(1:x));
end

H=At/A;

bar(N,H)
xlim([N(1) N(end)])

B=sum(N.*Hist);
C=sum((N.^2).*Hist);
D=sum((N.^3).*Hist);

X1=((B*D)-(C^2))/((A*C)-(B^2));
X2=((B*C)-A*D)/((A*C)-B^2);
X0=0.5-(((B/A)+(X2/2))/(sqrt((X2^2)-(4*X1))));

t=abs(H-X0);
idx_t=find(t==min(t))
Salida=zeros(size(img)); 
Salida(img>=idx_t)=255;               
