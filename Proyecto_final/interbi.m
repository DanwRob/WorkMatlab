function [CEImage] = interbi(I, tileMappings, numTiles,dimTile)
CEImage=zeros(size(I));

imgTileRow=1;
for k=1:numTiles(1)+1
  if k == 1  
    imgTileNumRows = fix(dimTile(1)/2); 
    mapTileRows = [1 1];
  else 
    if k == numTiles(1)+1    
      imgTileNumRows = fix(dimTile(1)/2);
      mapTileRows = [numTiles(1) numTiles(1)];
    else 
      imgTileNumRows = dimTile(1); 
      mapTileRows = [k-1, k]; 
    end
  end
  imgTileCol=1;
  for l=1:numTiles(2)+1
    if l == 1 
      imgTileNumCols = fix(dimTile(2)/2);
      mapTileCols = [1, 1];
    else
      if l == numTiles(2)+1 
        imgTileNumCols = fix(dimTile(2)/2);
        mapTileCols = [numTiles(2), numTiles(2)];
      else 
        imgTileNumCols = dimTile(2);
        mapTileCols = [l-1, l]; 
      end
    end
    
    % Extraer los 4 Mapas
    ulMapTile = tileMappings{mapTileRows(1), mapTileCols(1)};
    ulMapTile = tileMappings{mapTileRows(1), mapTileCols(2)};
    blMapTile = tileMappings{mapTileRows(2), mapTileCols(1)};
    brMapTile = tileMappings{mapTileRows(2), mapTileCols(2)};
    
    num = imgTileNumRows*imgTileNumCols;  %total de pixeles en el tile
    Bin=I(imgTileRow:imgTileRow+imgTileNumRows-1,imgTileCol:imgTileCol+imgTileNumCols-1);
    subImage = zeros(size(Bin));
            for i = 0:imgTileNumRows-1
                inverseI =imgTileNumRows- i;
                for j = 0:imgTileNumCols-1
                    inverseJ = imgTileNumCols - j;
                    val = Bin(i+1,j+1);
                    %se calcula la intensidad de grises en cada pixel
                    subImage(i+1,j+1) = fix((inverseI*(inverseJ*ulMapTile(val) + j*ulMapTile(val)) ...
                         + i*(inverseJ*blMapTile(val) + j*brMapTile(val)))/num);
                    
                end
            end
    %se asigna la subimagen a la imagen final 
    CEImage(imgTileRow:imgTileRow+imgTileNumRows-1,imgTileCol:imgTileCol+imgTileNumCols-1) = subImage;
    
    imgTileCol = imgTileCol + imgTileNumCols;    
  end %termina Col
  imgTileRow = imgTileRow + imgTileNumRows;
end %Termina rows