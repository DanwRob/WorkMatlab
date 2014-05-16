% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 2 de abril 2014
% 
% Tarea No:6
% 
% Titulo: Template Matching

function J=fftmatch(I,T,g) 
figure
subplot 231
imshow(I)
title('Imagen original')
marker=zeros(size(I));
[ym,xm]=size(T);
%Rotar plantilla
T=rot90(T,2);
subplot 232
imshow(T)
title('Imagen plantilla')
%FFT a la imagen original
I=fft2(I);
subplot 233
imshow(log(abs(fftshift(I))),[])
title('Espectro de frecuencia original')
[y,x]=size(I);
%FFT a la imagen plantilla agregando padding
T=fft2(T,y,x);
subplot 234
imshow(log(abs(fftshift(T))),[])
title('Espectro de frecuencia plantilla')
%multiplicacion de espectros
J=(T).*(I);
subplot 235
imshow(log(abs(fftshift(J))),[])
title('Multiplicacion de espectros')
%inversa de la FFT2
J=ifft2(J);
%seleccion del umbral
umbral=max(J(:));
umbral=umbral*0.95;
%seleccion de los puntos de la localizacion de los objetos
[idy,idx]=find(J>umbral);
idx=idx-floor(xm/2);
idy=idy-floor(ym/2);
idx=sub2ind([y x],idy,idx);
marker(idx)=255;
se=strel('square',ym);
J=imdilate(marker,se);
%extraccion del contorno
if(g==1)
    [J,~] = bwboundaries(J,'noholes');
    subplot 236
    imshow(ifft2(I))
    title('Concidencias')
    hold on
    for i=1:length(J)
    B =[J{i}];
    plot(B(:,2), B(:,1), 'y','LineWidth', 1);
    end
else
    subplot 236
    imshow(J)
end



