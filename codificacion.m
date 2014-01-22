clear all
close all
clc
intervalo=0.05;
p=(0:intervalo:1);
Hs=(-p.*log2(p))-((1-p).*log2(1-p));
f=find(isnan(Hs));
Hs(f)=0;
plot(p,Hs)

