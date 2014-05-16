function Y=icm(I,f,g,h,r,iteracion)
W=Gauss(r);
[H,w]=size(I);
Y=zeros(size(I));
I=mat2gray(I);
feeding=zeros(H,w);
T=ones(H,w);
for i=1:iteracion
    feeding=f.*feeding+conv2(Y, W,'same')+I;   
    Y(:,:)=0;
    Y(feeding>T)=1;
    T=(g.*T)+h.*Y;
    imshow(Y,[])
    pause(1)
    
end

