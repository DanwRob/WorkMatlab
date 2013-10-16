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

function Salida=imhistogram(img)% la función se llama imhistogram

idx=unique(img);
Salida=zeros(1, 256);

for i = 1:length(idx)                   %obtencion del histograma
     ind = find(img==idx(i));
     Salida(idx(i)+1)=length(ind);     
end 



        