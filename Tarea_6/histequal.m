
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

idx=unique(img);
Salida=zeros(1, 256);

for i = 1:length(idx)
        ind = find(img==idx(i));
     Salida(idx(i)+1)=length(ind);
end



        
