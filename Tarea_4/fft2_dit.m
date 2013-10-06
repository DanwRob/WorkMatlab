function Isalida=fft2_dit(img)
    [y,x]=size(img);
    temp=zeros(y,x);

    temp2=zeros(y,x);
    N1=x/2;
    N2=y/2;
    for l=1:y
       
        temp2(l,:)=img(l,:).*exp(((i*2*pi.*(((1:x).*N1)/x+(l*N2/y)))));
    end

    for j=1:y
       temp(j,:)=fft_dit(temp2(j,:));
   
    end
    
    temp=temp.';
  
    for j=1:x
   
     temp3(j,:)=fft_dit(temp(j,:));
    
    end
    temp3=temp3.';
    
   
Isalida=temp3;


