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

function img=fft2_dit(img)
    [Y,X]=size(img);

    N1=X/2;
    N2=Y/2;
    W=1j*2*pi;
    for x=1:Y
        img(x,:)=img(x,:).*exp(((W.*(((1:X).*N1)/X+(x*N2/Y)))));    %translada el centro de la imagen
    end
   
    img=img.';                              %se aplica la inversa a la matriz para tranformar las colunmas
    for x=1:X
     img(x,:)=fft_dit(img(x,:));            %Trasformas las columnas aplicando la FFT 1D
     img(x,:)=bitreversal(img(x,:));
    end
    img=img.';                              %se regresa la matriz a su posicion original
    
    for x=1:Y
       img(x,:)=fft_dit(img(x,:));          %Trasformas las filas aplicando la FFT 1D
       img(x,:)=bitreversal(img(x,:));
    end



