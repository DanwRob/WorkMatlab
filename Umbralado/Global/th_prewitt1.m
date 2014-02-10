function  t= th_prewitt1( inputImage )
%Prewitt1 Funcion para segmentar una imagen
H1=imhist(inputImage);  %Obtengo el histograma de la image
H2=H1;
count=0;

%suavizado del histograma utilizando un promedio de 3 puntos
while count ~= 1
    %suavizado del histograma
    for y=2:254
        H2(y)=(H1(y-1)+H1(y)+H1(y+1))/3;
    end
    count=0;
    for y=2:254
        if H2(y)<H2(y-1) && H2(y)<H2(y+1)
            count=count+1;
            t=y;
        end
    end
    H1=H2;
end
% inputImage(inputImage<t)=0;
% inputImage(inputImage>=t)=255;
% outputImage=inputImage;
end