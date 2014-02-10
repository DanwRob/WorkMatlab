function [ t ] = th_kittler1( inputImage )
%Kittler I Al igual que los métodos de Otsu y Ridler, el método de Kittler 
%se basa en agrupamiento de clases

H=imhist(inputImage);
An=A(H,255);
Cn=C(H,255);
Bn=B(H,255);
for t=1:255
    At=A(H,t);
    Bt=B(H,t);
    Ct=C(H,t);
    pt=At/An;
    qt=(An-At)/An;      
    Mt=B(H,t)/At;  
    Vt=(Bn-Bt)/(An-At);
    %Mt=pow2(Mt);
    %Vt = pow2(Vt);
    
    Sigma=sqrt((Ct/At)-Mt^2);
    Tao=sqrt(((Cn-Ct)/(An-At))-Vt^2);
    
    HH(t)=(pt*log10(Sigma/pt)) + (qt * log10(Tao/qt)); 
    
    
end
HH(isnan(HH))=0;
HH(isinf(HH))=0;
HH(HH==0)=max(HH);
x=min(HH);
t=find(HH==x,1);
end

