function [ t ] = th_tsai( inputImage )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
H=imhist(inputImage);  %Obtengo el histograma de la imagen

An=A(H,255);
Bn=B(H,255);
Cn=C(H,255);
Dn=D(H,255);

x1=((Bn*Dn)-Cn^2)/((An*Cn)-Bn^2);
x2=((Bn*Cn)-(An*Dn))/((An*Cn)-Bn^2);

x0=(1/2)-((Bn/An)+(x2/2))/(sqrt((x2^2)-4*x1));

for i=1:255
    AtAn=(A(H,i)/An);
    if AtAn>x0
        t=i-1;
        break;
    end
end
end

