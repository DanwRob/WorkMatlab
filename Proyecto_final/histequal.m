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

function [Salida,cdf]=histequal(img,clip)% la función se llama histequal
h=imhistogram(img); 

    ClipLimit=clip/100;
    
clip=max(h)*(ClipLimit);

     %Se calcula el histograma con la funcion imhistogram

total=0;
for i=1:256
    if h(i)>clip
        total=total+(h(i)-round(clip));
          h(i)=clip;
    end
end
if(total~=0)
    
    for i=1:(floor(total/256))
         h=h+1;
    end
    g=mod(total,256);
    if (g~=0)
        h(1:g)=h(1:g)+1;
    end
end

N=numel(img);
pdf=h.*N^-1 ;                   %Calculo de la PDF multiplicando el histograma por el numero de pixeles elevado -1

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




