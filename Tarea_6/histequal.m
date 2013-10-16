% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 16 de octubre 2013
% 
% Tarea No:6
% 
% Titulo: Ecualización global del histograma
% 
% ------------------------------------------------------------------------

function [Salida,cdf]=histequal(img)% la función se llama histequal

h=imhistogram(img);             %Se calcula el histograma con la funcion imhistogram
N=numel(img);
pdf=h.*N^-1;                    %Calculo de la PDF multiplicando el histograma por el numero de pixeles elevado -1

for k=1:length(pdf)
cdf(k)=256*sum(pdf(1:k));       %calculo de la CDF (Funcion de Distribucion Acomulada)
end


idx=unique(img);
Salida=zeros(size(img));
for i = 1:length(idx)
        ind = img==idx(i);         %se sustituyen los nuevos valores de grises en la imagen original
    Salida(ind)=cdf(idx(i)+1);
end 
Salida=uint8(Salida);




