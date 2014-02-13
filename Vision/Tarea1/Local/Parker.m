function [Salida]=Parker(img,valor)
b=str2double(valor(1));
s0=str2double(valor(3));
m0=str2double(valor(2));
k=str2double(valor(4));
Kernel = ones(b)*(1/(b*b));
Kernel_d=ones(b);
D=zeros(size(img));
G=[1 1 1;1 0 1; 1 1 1];

I_Pad=padarray(img,[1 1]);
[y,x]=size(I_Pad);
%se calcula el maximo brillo del gradiante en la vecindad de 8, para luego
%calcular D obteniendo el minimo de la diferencia de la imagen con la
%matriz aux
 for i=2:y-1
     for j=2:x-1
         aux=G.*double(I_Pad(i-1:i+1,j-1:j+1));
         aux(aux<=0)=max(aux(:));
         D(i-1,j-1)=min(min(double(I_Pad(i,j))-double(aux)));
     end
 end
 %Calculo de la media y desviacion estandar
 Media = imfilter(D,Kernel,'replicate');
 Desviacion=stdfilt(D,Kernel_d);
 %se asigna 0 o 1 depdendiendo de la condición que se cumpla
 Salida=zeros(size(img));
for i=1:numel(img)
    if Media(i)>=m0 || Desviacion(i)<s0
        Salida(i)=0;
    elseif D(i)<Media(i)+k*Desviacion(i)
        Salida(i)=1;
    end
end
 Salida=~Salida;
