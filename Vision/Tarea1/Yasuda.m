function [Salida]=Yasuda(I,valor)

w=valor(1);
T1=valor(2);
T2=valor(3);
T3=valor(4);
T4=valor(5);

I=imread('imagen/text1.tif');
I=double(I);

min_i=min(I(:));
max_i=max(I(:));

f1=255*((I-min_i)/(max_i-min_i));

kernel=[1,1,1;1,0,1;1,0,1];
min2=ordfilt2(f1,1,kernel);
max2=ordfilt2(f1,8,kernel);

r=max2-min2;
idx=find(r>T1);
f2=imfilter(f1,kernel/8,'replicate');
f2(idx)=f1(idx);


kernel2=ones(w);

max3=ordfilt2(f2,9,kernel2);
min3=ordfilt2(f2,1,kernel2);
Media=imfilter(f2,(kernel2/(w^2)),'replicate');

temp=max3-min3;
idx_2=find(temp<T2);
idx_3=find(f2>=Media);
f3=255*((f2-min3)./(Media-min3));

f3(idx_2)=255;
f3(idx_3)=255;

f4=zeros(size(I));
H=ones(3);
  
min4=ordfilt2(f3,1,H);
 
m=imfilter(f3,(H/9));
sumatoria=imfilter(  ((f3.^2)-m.^2) ,H);
S=sqrt(sumatoria)/3;
 
F=find(min4<T3);
F2=find(S>T4);
f4(F)=1;
f4(F2)=1;

Salida=f4;