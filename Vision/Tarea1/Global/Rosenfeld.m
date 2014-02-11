function [Salida,t,Hist]=Rosenfeld(img)

Hist=suavizar(img,5);
N=(1:256);

y=Hist';
w=sort(convhull(N,y));
y=zeros(1,256);
x=2;
for x=2:length(w)-1
    flag=w(x);
    A=linspace(Hist(w(x)),Hist(w(x+1)),w(x+1)-w(x)+1);
    y(flag:flag+length(A)-1)=A;
    flag=flag+length(A);
end

Diferencia=abs(Hist-y');


locales=zeros(256,1);
    for x=2:255
        if Diferencia(x-1)<Diferencia(x) && Diferencia(x)>Diferencia(x+1)  
            locales(x)=Diferencia(x);                                               
        end
    end
    Histograma=imhist(img);
    An=sum(Histograma);
    bj=zeros(256,1);
    Aj=zeros(256,1);
    for x=1:256
     Aj(x)=sum(Histograma(1:x));
    end
    bj=locales.*(Aj.*(An-Aj));
    t=find(bj==max(bj));
    
Salida=zeros(size(img));            
Salida(img>=t)=255;               
