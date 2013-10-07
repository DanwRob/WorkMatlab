function img=ifft2_dit(img)
    [Y,X]=size(img);

    for x=1:Y
       img(x,:)=ifft_dit(img(x,:));     %Trasformas las filas aplicando la DFT 1D
       img(x,:)=bitreversal(img(x,:));
    end
    
    img=img.';                          %se aplica la inversa a la matriz para tranformar las colunmas
  
    for x=1:X
   
     img(x,:)=ifft_dit(img(x,:));       %se aplica la inversa a la matriz para tranformar las colunmas
     img(x,:)=bitreversal(img(x,:));
    end
    img=img.';                          %se regresa la matriz a su posicion original



