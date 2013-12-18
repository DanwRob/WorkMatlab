function [Hist] = makeHistogram(bin,XSize,YSize,NrBins)
  % bin=Bin(1+(i-1)*XSize:i*XSize,1+(j-1)*YSize:j*YSize);
  Hist=zeros(1,NrBins);
        for i1=1:XSize
            for j1=1:YSize
                Hist(bin(i1,j1)) = Hist(bin(i1,j1)) + 1;
            end
        end

