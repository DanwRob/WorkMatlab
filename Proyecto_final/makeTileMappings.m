function tileMappings = ...
    makeTileMappings(I, numTiles, dimTile, numBins, clipLimit,...
                     selectedRange, fullRange, distribution, alpha)

numPixInTile = prod(dimTile);

tileMappings = cell(numTiles);

% extract and process each tile
imgCol = 1;
for col=1:numTiles(2),
  imgRow = 1;
  for row=1:numTiles(1),
    
    tile = I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1);

    % for speed, call MEX file directly thus avoiding costly
    % input parsing of imhist
    tileHist = imhistc(tile, numBins, 1, fullRange(2)); 
    
    tileHist = clipHistogram(tileHist, clipLimit, numBins);
    
    tileMapping = makeMapping(tileHist, selectedRange, fullRange, ...
                              numPixInTile, distribution, alpha);
    
    % assemble individual tile mappings by storing them in a cell array;
    tileMappings{row,col} = tileMapping;

    imgRow = imgRow + dimTile(1);    
  end
  imgCol = imgCol + dimTile(2); % move to the next column of tiles
end