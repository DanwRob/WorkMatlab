function Out = clahe2(I,nx,ny,clip,alfa,opt)
%-----------------------------------------------------------------------
% Genera indices de cada elemento de la reticula
n = 255;
I = double(I);
[Y,X] = size(I);
sizex = fix(X/nx);
sizey = fix(Y/ny);
sx = zeros(1,nx+1); sx(1) = 1; sx(end) = X;
sy = zeros(1,ny+1); sy(1) = 1; sy(end) = Y;
for i=2:length(sx)-1
   sx(i) = sx(i-1)+sizex;
   sy(i) = sy(i-1)+sizey;
end
% Mejoramiento adaptativo
Mapa = zeros(ny,nx,256);

for i = 1:length(sx)-1
   for j = 1:length(sy)-1 
       K = I(sy(j):sy(j+1),sx(i):sx(i+1));
       Hc = histogram(K,n);    
       if clip > 0
           Hc = cliphistogram(Hc,clip,n);
       end
       fa = histequal(Hc,alfa,opt);    
       Mapa(j,i,:) = fa;
   end
end
% interpolacion bilineal
Out = bilinear(I,Mapa,nx,ny);
Out = uint8(abs(Out));
%------------------------------------------------------------------------
function H = histogram(I,n)
I = double(I);
H = zeros(1,n+1);
I = I(:);
for i = 1:length(I) 
    H(I(i)+1) = H(I(i)+1) + 1;
end
%------------------------------------------------------------------------
function fa = histequal(Hc,alfa,opt)
gmin = 0;
gmax = 255;
P = Hc/sum(Hc);
Pf = cumsum(P);
switch opt
    case 'uniform'
        fa = gmin-(gmax-gmin)*Pf;
    case 'exponential'
        fa = gmin - (1/alfa)*log((1-Pf)+eps); % alfa pequeno
    case 'rayleigh'
        fa = gmin + sqrt(2*alfa^2*log((1./(1-Pf))+eps)); %alfa grande
end

%------------------------------------------------------------------------
function Hc1 = cliphistogram(Hc,clip,n)
c = fix(clip*max(Hc));
Hc1 = Hc; 
Hc1(Hc>=c) = c;
Hc2 = abs(Hc-Hc1);
num = sum(Hc2);
while num > 0
  for k = 1:n+1
     Hc1(k) = Hc1(k)+1;
     num = num-1;
     if num == 0
         break;
     end
  end
end
%------------------------------------------------------------------------
function CEImg = bilinear(I,Mapa,nx,ny)
[Y,X] = size(I);
sizex = fix(X/nx);
sizey = fix(Y/ny);
CEImg = zeros(Y,X);
xI = 1;
for i = 1:nx+1
    if i == 1
        subX = fix(sizex/2);
        xU = 1;
        xB = 1;
    elseif i == nx+1
        subX = fix(sizex/2);
        xU = nx;
        xB = nx;
    else
        subX = sizex;
        xU = i - 1;
        xB = i;
    end
    yI = 1;
    for j = 1:ny+1
        if j == 1
            subY = fix(sizey/2);
            yL = 1;
            yR = 1;
        elseif j == ny+1
            subY = fix(sizey/2);
            yL = ny;
            yR = ny;
        else
            subY = sizey;
            yL = j - 1;
            yR = j;
        end
        UL = Mapa(xU,yL,:);
        UR = Mapa(xU,yR,:);
        BL = Mapa(xB,yL,:);
        BR = Mapa(xB,yR,:);
        subImg = I(yI:yI+subY-1,xI:xI+subX-1);
        subImg = interpolate(subImg,UL,UR,BL,BR,subX,subY);
        CEImg(yI:yI+subY-1,xI:xI+subX-1) = subImg;
        yI = yI + subY;
    end
    xI = xI + subX;
end
%-----------------------------------------------------------------------
function [subImage] = interpolate(subBin,LU,LB,RU,RB,XSize,YSize)
subImage = zeros(size(subBin));
num = XSize * YSize;
for i = 0:YSize-1
    inverseI = YSize - i;
    for j = 0:XSize-1
        inverseJ = XSize - j;
        val = subBin(i+1,j+1)+1;
        subImage(i+1,j+1) = fix((inverseI*(inverseJ*LU(val) + j*RU(val)) + i*(inverseJ*LB(val) + j*RB(val)))/num);
    end
end