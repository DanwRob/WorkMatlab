function [Salida,idx_t,Hist]=Kittler1(img)
[Hist,N]=imhist(img);
A=sum(Hist);
B=sum(N.*Hist);
C=sum((N.^2).*Hist);
pt=zeros(256,1);
qt=zeros(256,1);
media=zeros(256,1);
Varianza=zeros(256,1);
% se realiza el calculo de las estadisticas usadas, media, varianza, 
for x=1:256
    Ct=sum((N(1:x).^2).*Hist(1:x));
    At=(sum(Hist(1:x)));
    Bt=(sum(N(1:x).*Hist(1:x)));
    pt(x)=At/A;
    qt(x)=(A-At)/A;
    Miu=Bt/At;
    Vt=(B-Bt)/(A-At);
    Varianza(x)=(Ct/At)-Miu^2;
    media(x)=((C-Ct)/(A-At))-Vt^2;

end
    Varianza=sqrt(Varianza);
    media=sqrt(media);
    Ei=(pt.*log10(Varianza./pt)) + (qt.* log10(media./qt)); % se calcula Ei para obtener el valor del umbral t
    Ei(isinf(Ei))=NaN;
    Ei(isnan(Ei))=max(Ei);
    t=min(Ei);                                              % el umbral t es el min de Ei
    idx_t=find(Ei==t,1);
    Salida=zeros(size(img));            
    Salida(img>=idx_t)=255; 