function [Salida,idx_t,Hist]=Ramesh(img)
[Hist,N]=imhist(img);
A=sum(Hist);
B=sum(N.*Hist);
Er=sum(Hist);

for x=1:256
    E1=0;
    E2=0;
    %calculo de variables estadisticas, Media y varianza.
    At=(sum(Hist(1:x)));
    Bt=(sum(N(1:x).*Hist(1:x)));
    Miu=Bt/At;
    Vt=(B-Bt)/(A-At);
    %calculo de errores cuadraticos E1, E2
    for j=1:x
        E1=E1+((j-Miu)^2);
    end
    for k=x+1:256
        E2=E2+((k-Vt)^2);
    end
    
    %suma de errores cuadraticos
    Er(x)=E1+E2;
end
 Er(isinf(Er))=NaN;
 Er(isnan(Er))=max(Er);
 t=min(Er);                 %el umbral t se obtiene en el min de Er la suma de errores cuadraticos
 idx_t=find(Er==t,1);
 Salida=zeros(size(img));            
 Salida(img>=idx_t)=255; 