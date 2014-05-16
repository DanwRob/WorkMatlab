% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 22 de Marzo 2014
% 
% Tarea No:5
% 
% Titulo: Segmentacion de Textura con filtros de Gabor


function gabor=gaborsegment(I,K,b,theta,alpha,T)
 theta=degtorad(theta);                 %se convierte de grados a radianes
 I=double(I);
 [M,N]=size(I);
 [u,v]=meshgrid(-N/2:N/2,-M/2:M/2);
 temp=2.^(1:N/4);
 idx=temp<=N/4&temp>2;
 
 temp=temp(idx);
 u0=ones(1,1,length(temp));
 u0(1,1,:)=temp;
 u0=u0.*sqrt(2);
 [~,~,z]=size(u0);
 k=1;
 u0=repmat(u0,M+1,N+1);
 %Calculo de los filtros de Gabor
 for i=0:theta:pi
        u_prima=u*cos(i)+v*sin(i);
        v_prima=v*cos(i)-u*sin(i);
        lamda=1./u0;
        u_prima=repmat(u_prima,[1,1,z]);
        v_prima=repmat(v_prima,[1,1,z]);
        sigma=(lamda./pi)*sqrt( (log(2)/2) )* ( ((2^b)+1) / ((2^b)-1) );
        sigma_u=1/(2*pi.*sigma);
        sigma_v=1/(2*pi.*sigma);
        H=exp(-0.5.*(( ((u_prima-u0).^2)./sigma_u.^2)+((v_prima.^2)./sigma_v.^2)))...
            +exp(-0.5.*( ( ((u_prima+u0).^2)./sigma_u.^2) +((v_prima.^2)./sigma_v.^2) ) );
        gabor(:,:,:,k)=H;
        k=k+1;
 end

 Gabor=gabor(:,:,:,1:k-2);
 %Se pasa la imagen al dominio de la frecuencia FFT
 I_F=fft2(I,M+1,N+1);
 I_F=fftshift(I_F);
 [y_f,x_f]=size(I_F);
 I_F(ceil(y_f/2),ceil(x_f/2))=0;
 [y, x, z, w]=size(Gabor);
 I_F=repmat(I_F,[1,1,z,w]);
 
 %se multiplica la imagen en en dominio de la frecuencia con cada...
 % uno de los filtros generados.
 I_prima=I_F.*Gabor;
 %se aplica la inversa de la FFT
 a=uint8(abs(ifft2(I_prima)));
 %se transforma la imagen al domino de la frecuencia FFT
 I_F_prima=fft2(a);
 figure
 subplot 231
   imshow(I,[])
title 'Original'
 for i=1:z
     for j=1:w      
        
        subplot 232        
        I_F_prima(:,:,i,j)=fftshift(I_F_prima(:,:,i,j));
        imshow(Gabor(:,:,i,j),[])
        pause(0.1)
     end
 end
 imshow(sum(sum(Gabor,4),3),[])
 title 'Filtros de Gabor'
 %homogeneizar cada region aplicando un suavizado gaussiano
 sigma=T.*(N./u0);
 u=repmat(u,[1,1,z]);
 v=repmat(v,[1,1,z]);
 G=exp(-0.5.*( (u.^2./sigma.^2) + (v.^2./sigma.^2) ) );
 G=repmat(G,[1,1,1,w]);
 I_F_prima=I_F_prima.*G;
 %Se transforma al dominio del espacio IFFT2
 a=(abs(ifft2(I_F_prima)));
 %calcular S
 S=sum(sum(a,4),3);
 subplot 233
 imshow(S,[])
 title 'S'
 a=double(reshape(a,y,x,w*z));
 R=zeros(1,w*z);
 %calcular SSTOT
 SSTOT=sum(sum(S.^2));
 %seleccion del mejor subonjunto de imagenes filtradas
 for i=1:z*w
       SSE=(a(:,:,i)-S).^2;
       SSE=sum(SSE(:));
       R(i)=1-(SSE/SSTOT);     
 end
 [r,idxR]=max(R);
 best=a(:,:,idxR);
 a(:,:,idxR)=0;
 l=1;
 while r<0.95
     S_hat=repmat(best,[1,1,z*w])+a;
     for i=1:z*w         
         SSE=(S_hat(:,:,i)-S).^2;
         SSE=sum(SSE(:));
         R(i)=1-(SSE/SSTOT);
     end
    [r,idxR]=max(R);
    best=S_hat(:,:,idxR);
    S_prima(:,:,l)=a(:,:,idxR);
    l=l+1;
    a(:,:,idxR)=0;
    
 end
[y,x,z]=size(S_prima);
%Saturacion
saturado=((1-exp(-2.*alpha.*S_prima))./(1+exp(-2.*alpha.*S_prima)));

subplot 234
imshow(sum(S_prima,3),[])
title 'Seleccionadas'

subplot 235
imshow(sum(saturado,3),[])
title 'Saturada'
%datos para el k-means
kdata=reshape(saturado,y*x,z);
%calculando cordenadas espaciales
[meshx,meshy]=meshgrid(1:x,1:y);
meshx=reshape(meshx,[],1);
meshy=reshape(meshy,[],1);
mesh=[meshx meshy]/x;
%agregando cordenadas espaciales
kdata=[mesh kdata];
%aplicar k-means
prueba=kmeans(kdata,K);
prueba=reshape(prueba,y,x);

subplot 236
imshow(prueba,[]);
title 'Segmentada'