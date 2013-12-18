function mapping = makeMap(Hist,Rango,numPixInTile)

mapping = zeros(size(Hist));
histSum = cumsum(Hist);
valSpread  = Rango(2) - Rango(1);

 scale =  valSpread/numPixInTile;
 mapping = fix(min(Rango(1) + histSum*scale,Rango(2)));
