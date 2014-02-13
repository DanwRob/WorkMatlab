function [Salida,idx_t,Hist]=Kittler2(img)
[Hist,N]=imhist(img);
t=256/2;
aux=1;
A=sum(Hist);
B=sum(N.*Hist);
C=sum((N.^2).*Hist);

media=zeros(256,1);
Varianza=zeros(256,1);
while aux
    % se calculan pt, qt, varianza, y media
    Ct=sum((N(1:t).^2).*Hist(1:t));
    At=(sum(Hist(1:t)));
    Bt=(sum(N(1:t).*Hist(1:t)));
    pt=At/A;
    qt=(A-At)/A;
    Miu=Bt/At;
    Vt=(B-Bt)/(A-At);
    Varianza=(Ct/At)-Miu^2;
    media=((C-Ct)/(A-At))-Vt^2;
    %calculo de los 3 terminos de la ecuacion cuadratica
    %omega,omega2,omega3
   omega=(1/Varianza)-(1/media);
   omega2=(Miu/Varianza)-(Vt/media);
   omega3=((Miu^2/Varianza)-(Vt^2/media))+log((Varianza*qt^2)/(media*pt^2));
   %calculo de umbral t_s
   t_s=(omega2+sqrt(omega2^2-(omega*omega3)))/(omega); 
   if t==floor(t_s) %si t=t_s el ciclo termina y el umbral t es encontrado.
       aux=0;
   end
   t=floor(t_s);%se asigna el valor del nuevo umbral
end
   idx_t=t;
    Salida=zeros(size(img));            
    Salida(img>=idx_t)=255; 