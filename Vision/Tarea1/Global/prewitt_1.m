function [Salida,Hist,idx]=prewitt_1(img)
[Hist,idx]=suavizar(img,3);            %Funcion para suavizar el histograma...
valle=min(Hist(idx(1):idx(2)));     %Obtener valle entre los 2 picos
idx(3)=find(Hist==valle);           %guarda el valle en la posicion 3 de idx
Salida=zeros(size(img));            %si pixel es mayor o igual a la posicion del valle..
Salida(img>=idx(3))=255;               %se vuelve 1, en caso contrario 0
