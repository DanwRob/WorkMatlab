

img=imread('rose.tif');
[Hist,idx]=suavizar(img,5);
N=(1:256);

figure
bar(N',Hist)
figure
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
area(y);

Diferencia=abs(Hist-y');
figure
bar(N,Diferencia)

locales=zeros(256,1);
    for x=2:255
        if Diferencia(x-1)<Diferencia(x) && Diferencia(x)>Diferencia(x+1)   %comprueba si es pico.       
            locales(x)=Diferencia(x);                                                %vector de indice de picos.
        end
    end
    
    figure
    bar(N,locales)
    
    Histograma=imhist(img);
    An=sum(Histograma);
    bj=zeros(256,1);
    Aj=zeros(256,1);
    for x=1:256
     Aj(x)=sum(Histograma(1:x));
    end
    bj=locales.*(Aj.*(An-Aj));
    
    figure
    bar(N,bj)