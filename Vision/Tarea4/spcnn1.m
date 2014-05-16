function Y=spcnn1(I,at,vt,b,r,iteracion)
W=Gauss(r);
[H,w]=size(I);
Y=zeros(size(I));
feeding=I;
T=ones(H,w);
for i=1:iteracion
    linking=conv2(Y, W,'same');
    U=feeding.*(1+b.*linking);
    Y(:,:)=0;
    Y(U>T)=1;
    T=(exp(-at).*T)+vt.*Y;
    imshow(Y,[])
    pause(1)
    
end