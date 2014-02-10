clear all, close all, clc

intervalo=0.08;
[x,y]=meshgrid(0:intervalo:1);
z=ones(size(x));
z=1-(x+y);

f=find(z<0);
z(f)=NaN;

alfa=(-x.*log2(x));
f1=find(isnan(alfa));
alfa(f1)=0;

beta=(-y.*log2(y));
f1=find(isnan(beta));
beta(f1)=0;

fab=(-z.*log2(z));
f1=find(isnan(fab));
fab(f1)=0;

Hs3=alfa+beta+fab;
Hs3(f)=NaN;
lz=(0:intervalo:max(Hs3(:))+.1);
lx=ones(size(lz));
lx(:)=0.33;
ly=(0:intervalo:1/3);

figure

surf(x,y,Hs3,'FaceColor','red', 'EdgeColor','none')
camlight left; lighting phong
hold on
line(lx,lx,lz,'linestyle', '--')
lz(:)=max(Hs3(:));
line(ly,lx(1:length(ly)),lz(1:length(ly)),'linestyle', '--')


