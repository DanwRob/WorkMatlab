function [ t ] = th_ramesh( inputImage )
%th_ramesh El método de Ramesh trata de modelar la forma del
%histograma mediante una aproximación multinivel.


H=imhist(inputImage);
n=length(H);
An=A(H,n);
Bn=B(H,n);
E1=0;
E2=0;
for t=1:n
    Bt=B(H,t);
    At=A(H,t);
    Mt=Bt/At;  
    
    if(isnan(Mt))
        Mt=0;
    end
    Vt=(Bn-Bt)/(An-At);
    
    for i=0:t
        E1=E1+((i-Mt)^2);
    end
    
    for i=t+1:n
        E2=E2+((i-Vt)^2);
    end   
    
    Et(t)=E1+E2;
    E1=0;
    E2=0;
end
Et(isnan(Et))=0;
Et(isinf(Et))=0;
Et(Et==0)=max(Et);
x=min(Et);
t=find(Et==x,1);
end

