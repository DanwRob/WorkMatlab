function [subImage] = interpolate(subBin,LU,RU,LB,RB,XSize,YSize)

subImage = zeros(size(subBin));
num = XSize * YSize;
for i = 0:XSize-1
    inverseI = XSize - i;
    for j = 0:YSize-1
        inverseJ = YSize - j;
        val = subBin(i+1,j+1);
        subImage(i+1,j+1) = fix((inverseI*(inverseJ*LU(val) + j*RU(val)) ...
             + i*(inverseJ*LB(val) + j*RB(val)))/num);
    end
end

