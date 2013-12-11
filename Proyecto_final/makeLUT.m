function [LUT] = makeLUT(Min,Max,NrBins)
%  To speed up histogram clipping, the input image [Min,Max] is scaled down to
%  [0,uiNrBins-1]. This function calculates the LUT.

BinSize = fix(1 + (Max - Min)/NrBins);
LUT = zeros(fix(Max - Min),1);
for i=Min:Max
    LUT(i) = fix((i - Min)/BinSize);
end

