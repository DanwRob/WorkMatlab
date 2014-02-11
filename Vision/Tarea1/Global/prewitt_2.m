function [Salida,Hist,idx]=prewitt_2(img)
[Hist,idx]=suavizar(img,3);            %Funcion para suavizar el histograma...
umbral=(idx(1)+idx(2))/2;            %Calcula el umbral
idx(3)=round(umbral);           %guarda el valle en la posicion 3 de idx
Salida=zeros(size(img));             %si pixel es mayor o igual a la posicion del valle..
Salida(img>=idx(3))=255;             %se vuelve 1, en caso contrario 0
