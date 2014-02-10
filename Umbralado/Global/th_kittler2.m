function [ t ] = th_kittler2( inputImage )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

H=imhist(inputImage);
t=(length(H))/2;
An=A(H,255);
Cn=C(H,255);
Bn=B(H,255);
parar=0;
t2=0;

while parar==0
    At=A(H,t);
    Bt=B(H,t);
    Ct=C(H,t);
    pt=At/An;
    qt=(An-At)/An;      
    Mt=B(H,t)/At;  
    Vt=(Bn-Bt)/(An-At);
    
    Sig=sqrt((Ct/At)-Mt^2);
    Tao=sqrt(((Cn-Ct)/(An-At))-Vt^2);
    
    w0=(1/(Sig^2))-(1/(Tao^2));
    w1=((Mt)/(Sig^2)) - ((Vt)/(Tao^2));
    w2=((Mt^2)/(Sig^2))-((Vt^2)/(Tao^2))+log(((Sig^2)*(qt^2))/((Tao^2)*(pt^2)));
    
    % calculo del nuevo umbral
    t2=(w1+sqrt(w1^2-(w0*w2)))/(w0);
    if t2==t
        parar=1;
    else
        t=t2;
    end
end
t=floor(t);
end

