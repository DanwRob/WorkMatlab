function Isalida=idft2(img)
    [y,x]=size(img);
    temp=zeros(y,x);
  

    for j=1:y
       temp(j,:)=idft(img(j,:));
   
    end
    
    temp=temp.';
  
    for j=1:x
   
     temp3(j,:)=idft(temp(j,:));
    
    end
    temp3=temp3.';
   
   
Isalida=temp3;
