function [I,picos]=suavizar(img,puntos)
[I]=imhist(img);        %calculo del histograma.
I = I/sum(I);           %Normalizacion del histograma.
    
H=ones(puntos,1);
H=H/puntos;                  %Vector para el promediado de 3 puntos.
picos=zeros(1,3);
loop=0;
while loop~=2           % repetir hasta encontrar unicamente 2 picos.
    loop=0;
    I=imfilter(I,H);    %Suavizado del histograma por promedio de 3 puntos.
    for x=2:255
        if I(x-1)<I(x) && I(x)>I(x+1)   %comprueba si es pico.
            loop=loop+1;        
            if loop<3
                picos(loop)=x-1;        %vector de indice de picos.
            end
        end
    end
    if puntos==5
        loop=2;
    end
end

