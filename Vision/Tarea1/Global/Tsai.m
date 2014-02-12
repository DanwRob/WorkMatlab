function [Salida,idx_t,Hist]=Tsai(img)
[Hist,N]=imhist(img);       %Se calcula el histograma


At=zeros(256,1);
A=sum(Hist);               
for x=1:256
     At(x)=sum(Hist(1:x));
end

H=At/A;                         %se calculan los posibles umbrales

bar(N,H)
xlim([N(1) N(end)])

B=sum(N.*Hist);                 %calculo de las sumas parciales
C=sum((N.^2).*Hist);
D=sum((N.^3).*Hist);

X1=((B*D)-(C^2))/((A*C)-(B^2)); %calculo de X1 usando las sumas parciales
X2=((B*C)-A*D)/((A*C)-B^2);                        %calculo de X2 
X0=0.5-(((B/A)+(X2/2))/(sqrt((X2^2)-(4*X1))));      %calculo X0

t=abs(H-X0);                    %diferencia del histograma y X0
idx_t=find(t==min(t));           %el umbral t se obtiene cuando el valor Xo se acerca a At/A
Salida=zeros(size(img)); 
Salida(img>=idx_t)=255;        %se asigna 255 si el pixel es mayor al umbral t, en caso comtratop se asigna 0       
