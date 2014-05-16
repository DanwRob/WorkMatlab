function Y=pcnn(I,af,al,at,vf,vl,vt,b,r,iteracion)
M=Gauss(r);
W=M;
[H,w]=size(I);
Y=zeros(size(I));
feeding=zeros(H,w);
linking=feeding;
T=ones(H,w);
for i=1:iteracion
    feeding=exp(-af).*feeding+vf.*conv2(Y, W,'same')+I;
    linking=exp(-al).*linking+vl.*conv2(Y, M,'same');
    U=feeding.*(1+b.*linking);
    Y(:,:)=0;
    Y(U>T)=1;
    T=(exp(-at).*T)+vt.*Y;
    imshow(Y,[])
    pause(1)
    
end