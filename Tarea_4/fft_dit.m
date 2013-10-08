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

function g=fft_dit(g)

 N=length(g);
 dx=log2(N);
 delta=2^(dx-1);
%se aplica el algoritmo de decimación en frecuencia de base-2, se obtinene realizado con las suma y la diferencia entre la primera y segunda mitades de la secuencia de entrada.
   for pass=1:dx
     w=exp(-1*((1i*2*pi)/(2*delta)));
     for b=0:delta-1
        for a=0:2*delta:N-1
         t0=g(b+a+1)+g(b+delta+a+1);
         t1=(w^b)*(g(b+a+1)-g(b+delta+a+1));
         g(b+a+1)=t0;
         g(b+delta+a+1)=t1;
        end
     end
      delta=delta/2;
  end 
    