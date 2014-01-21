clear all
close all
clc
intervalo=0.2;
%p=(0:intervalo:1);
%Hs=(-p.*log2(p))-((1-p).*log2(1-p));
%f=find(isnan(Hs));
%Hs(f)=0;
%plot(p,Hs)

k=1;


for i = 0:intervalo:1
    for j=0:intervalo:i
        x(k)=1-i;
        y(k)=i-j;
        z(k)=1-(x(k)+y(k));
        k=k+1;
    end
end

[ax,ay]=meshgrid(x,y);

az=ax-ay;
Hs3=(-ax.*log2(ax))+(-ay.*log2(ay))+(-az.*log2(az));
f=find(isnan(Hs3));
Hs3(f)=0;
figure
surf(ax,ay,Hs3)
