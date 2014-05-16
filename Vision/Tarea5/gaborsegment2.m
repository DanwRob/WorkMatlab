function gabor=gaborsegment2(I,K,b,theta,alpha,T)
theta=degtorad(theta);
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
%         for j=1:z
%         surf(u,v,gabor(:,:,j,k));hold on
%         axis([-N/2 N/2 -M/2 M/2])
%         shading interp
%         end
        k=k+1;
 end


 I_F=fft2(I,M+1,N+1);
 I_F=fftshift(I_F);
 [y_f,x_f]=size(I_F);
 I_F(ceil(y_f/2),ceil(x_f/2))=0;
 [y, x, z, w]=size(gabor);
 I_F=repmat(I_F,[1,1,z,w]);
 I_prima=I_F.*gabor;
 
 a=uint8(abs(ifft2(I_prima)));
 I_F_prima=fft2(a);
 
 figure
 for i=1:z
     for j=1:w
        subplot 231
        imshow(a(:,:,i,j),[])
        subplot 232
        I_F_prima(:,:,i,j)=fftshift(I_F_prima(:,:,i,j));
%         imshow(log(1+abs(I_F_prima(:,:,i,j))),[])
        imshow(gabor(:,:,i,j),[])
        pause(0.1)
     end
 end
 imshow(sum(sum(gabor,4),3),[])
 
 sigma=T.*(N./u0);
 u=repmat(u,[1,1,z]);
 v=repmat(v,[1,1,z]);
 G=exp(-0.5.*( (u.^2./sigma.^2) + (v.^2./sigma.^2) ) );
%  figure
%  imshow(G(:,:,3),[])
 G=repmat(G,[1,1,1,w]);
 I_F_prima=I_F_prima.*G;
 
 a=(abs(ifft2(I_F_prima)));
%  figure
%  for i=1:z
%      for j=1:w
%         subplot 231
%         imshow(G(:,:,i,j),[])
%         subplot 232
%         imshow(a(:,:,i,j),[])
%         pause(0.10)
%      end
%  end
 
 S=sum(sum(a,4),3);
 subplot 233
 imshow(S,[])
 a=double(reshape(a,y,x,w*z));
 R=zeros(1,w*z);
 SSTOT=sum(sum(S.^2));
 
 for i=1:z*w
       SSE=(a(:,:,i)-S).^2;
       SSE=sum(SSE(:));
       R(i)=1-(SSE/SSTOT);     
 end
 [r,idxR]=max(R);
 best=a(:,:,idxR);
 a(:,:,idxR)=0;
 %S_prima=zeros(y,x,w*z);
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

saturado=((1-exp(-2.*alpha.*S_prima))./(1+exp(-2.*alpha.*S_prima)));
% for i=1:z
%     subplot 234
%     imshow(S_prima(:,:,i),[])
%     
%      subplot 235
%      imshow(saturado(:,:,i),[])
%      pause(0.2)
% end
subplot 234
imshow(sum(S_prima,3),[])
subplot 235
imshow(sum(saturado,3),[])

kdata=reshape(saturado,y*x,z);
prueba=kmeans(kdata,K);

prueba=reshape(prueba,y,x);
subplot 236
imshow(prueba,[]);