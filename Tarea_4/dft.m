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
function Y=dft(img)

N=length(img);
g=(0:N-1);
W=1i*2*pi;
    for k=0:N-1
        Y(k+1)=sum(img.*(exp(-1*((W.*g.*k)/N))));  %Se aplica la Inversa de Tranformada Discreta de Fourier 1D
        
    end
   