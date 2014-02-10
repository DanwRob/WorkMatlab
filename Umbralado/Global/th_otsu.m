function [ t ] = th_otsu( inputImage )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
H=imhist(inputImage);

for i=1:255
    M=B(H,i)/A(H,i);  
    V=(B(H,255)-B(H,i))/(A(H,255)-A(H,i));
    H2(i)=A(H,i)*(A(H,255)-A(H,i))*((M-V)^2);
end
x=max(H2);
t=find(H2==x,1);
end

