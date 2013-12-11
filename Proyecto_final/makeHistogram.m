function [Hist] = makeHistogram(Bin,XSize,YSize,NrX,NrY,NrBins)

Hist=zeros(NrY,NrX,NrBins);
for i=1:NrY
    for j=1:NrX
      bin=Bin(1+(i-1)*YSize:i*YSize,1+(j-1)*XSize:j*XSize);
        for i1=1:YSize
            for j1=1:XSize
                Hist(j,i,bin(i1,j1)) = Hist(j,i,bin(i1,j1)) + 1;
            end
        end
    end
end
