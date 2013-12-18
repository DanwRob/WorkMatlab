function [CEImage] = clahe(Image,numTiles,Cliplimit)
[YRes,XRes]=size(Image);
CEImage=uint8(Image);
numBins=256;
XSize = round(XRes/numTiles(1));
YSize = round(YRes/numTiles(2));
%Determina las rangos de las secciones a explorar
sx = zeros(1,numTiles(1)+1); sx(1) = 1; sx(end) = XRes;
sy = zeros(1,numTiles(2)+1); sy(1) = 1; sy(end) = YRes;
for i=2:length(sx)-1
   sx(i) = sx(i-1)+XSize;
   sy(i) = sy(i-1)+YSize;
end
%tamaño de cada tile
dimTile =fix( [YRes,XRes] ./ numTiles);
numPixInTile = prod(dimTile);               %pixeles totales en cada tile
tileMappings = cell(numTiles);              %Cell array para los histogramas

LUT=makeLUT(min(Image(:)),max(Image(:)),256);
Bin=1+LUT(round(Image));
for Row=1:numTiles(2)
    for Col=1:numTiles(1)
        %extraccion de cada title
        tile = Bin(sy(Row):sy(Row+1),sx(Col):sx(Col+1));
        %hist=imhist(tile,numBins);                             
        YSize=sy(Row+1)-sy(Row); XSize=sx(Col+1)-sx(Col);
        hist= makeHistogram(tile,YSize,XSize,numBins);
        tile_temp=cliphist(hist,Cliplimit,numBins);           %corte del histograma
        tileMap = makeMap(tile_temp,[0 255],numPixInTile);     %Calculo de CDF
        tileMappings{Row,Col} = tileMap;                         
    end 
end
%interpolacion bilineal
CEImage = interbi(CEImage, tileMappings, numTiles,dimTile);          
CEImage = uint8(abs(CEImage));
