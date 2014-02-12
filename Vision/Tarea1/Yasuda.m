clear all
close all
clc

w=5;
T1=20;
T2=20;
T3=200;
T4=T3;
 
 
I=imread('imagen/text1.tif');
I=double(I);

min_i=min(I(:));
max_i=max(I(:));

f1=255*((I-min_i)/(max_i-min_i));

kernel=[1,1,1;1,0,1;1,0,1];
min2=ordfilt2(f1,1,kernel);
max2=ordfilt2(f1,8,kernel);

r=max2-min2;
idx=find(r>f1);
f2=imfilter(f1,kernel/8,'replicate');
f2(idx)=f1(idx);

imshow(f2,[])

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

imshow(f3,[])