function [Salida,t,Hist]=Rosenfeld(img)

Hist=suavizar(img,5);       %Suavizar histograma de la imagen
N=(1:256);

y=Hist';
w=sort(convhull(N,y));      %envoltura convexa del histograma
y=zeros(1,256);
x=2;
for x=2:length(w)-1
    flag=w(x);
    A=linspace(Hist(w(x)),Hist(w(x+1)),w(x+1)-w(x)+1); %une los puntos de la envoltura convexa
    y(flag:flag+length(A)-1)=A;
    flag=flag+length(A);
end

Diferencia=abs(Hist-y');    %Diferencia puntal Hist-y


locales=zeros(256,1);
    for x=2:255
        if Diferencia(x-1)<Diferencia(x) && Diferencia(x)>Diferencia(x+1)  
            locales(x)=Diferencia(x);                                         %encontrar maximos locales.      
        end
    end
    Histograma=imhist(img);
    An=sum(Histograma);
    bj=zeros(256,1);
    Aj=zeros(256,1);
    for x=1:256
     Aj(x)=sum(Histograma(1:x));
    end
    bj=locales.*(Aj.*(An-Aj));                  %calculo del balance del bj.
    t=find(bj==max(bj));                    %umbral t se encuentra en el máximo de bj.
    
Salida=zeros(size(img));                    %se asigna 255 si el pixel es mayor al umbral t, en caso comtratop se asigna 0
Salida(img>=t)=255;               
