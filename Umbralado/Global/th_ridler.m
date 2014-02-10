function [ t ] = th_ridler( inputImage )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
H=imhist(inputImage);
a=1;
t=255/2;
while a
    Mt=B(H,t)/A(H,t);  
    Vt=(B(H,255)-B(H,t))/(A(H,255)-A(H,t));
    t2=(Mt+Vt)/2;
    if t2==t
        a=0;
    else
        t=t2;
    end
end
t=floor(t);
end

