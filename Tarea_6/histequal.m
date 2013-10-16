
% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 14 de octubre 2013
% 
% Tarea No:6
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------

function Salida=histequal(img)% la función se llama imgraytrans

h=imhistogram(img);
figure;
bar(0: 255, h);
axis([0 255 0 max(h)])

N=numel(img);
pdf=h.*N^-1;

for k=1:length(pdf)

cdf(k)=255*sum(pdf(1:k));
end


idx=unique(img);
Salida=zeros(size(img));
for i = 1:length(idx)
        ind = find(img==idx(i));
    Salida(ind)=cdf(idx(i)+1);
end 





