function img=dft2(img)
    [Y,X]=size(img);

    N1=X/2;
    N2=Y/2;
    W=1j*2*pi;
    for x=1:Y                   
        img(x,:)=img(x,:).*exp(((W.*(((1:X).*N1)/X+(x*N2/Y)))));     %translada el centro de la imagen
    end
    
    img=img.';                              %se aplica la inversa a la matriz para tranformar las colunmas
  
    for x=1:X
   
     img(x,:)=dft(img(x,:));                %Trasformas las columnas aplicando la DFT 1D
    
    end
    img=img.';                               %se regresa la matriz a su posicion original
  
    for x=1:Y
       img(x,:)=dft(img(x,:));              %Trasformas las filas aplicando la DFT 1D
   
    end


