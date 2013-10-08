% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 08 de Octubre 2013
% 
% Tarea No:4
% 
% Titulo: Transformada de Fourier Directa y Rapida
% 
% ------------------------------------------------------------------------

function img=bitreversal(img)
N=length(img);
b=1;
N2=N/2;
%Algoritmo de Gold-Rader para el reacomodo de las posiciones
for a=2:N
    N1=N2;
    while (b>N1)
        b=b-N1;
        N1=N1/2;
    end
    b=b+N1;
    if a<b
        t1=img(a);
        img(a)=img(b);
        img(b)=t1;
    end
end

