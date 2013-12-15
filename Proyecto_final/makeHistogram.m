function [Hist] = makeHistogram(Bin,XSize,YSize,NrX,NrY,NrBins)

Hist=zeros(NrX,NrY,NrBins);

for i=1:NrX
    for j=1:NrY
        bin=Bin(1+(i-1)*XSize:i*XSize,1+(j-1)*YSize:j*YSize);
        for i1=1:XSize
            for j1=1:YSize
                Hist(i,j,bin(i1,j1)) = Hist(i,j,bin(i1,j1)) + 1;
            end
        end
    end
end
