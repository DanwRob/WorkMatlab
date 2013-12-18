
function claheI = makeClaheImage(I, tileMappings, numTiles, selectedRange,...
                                 numBins, dimTile)

%initialize the output image to zeros (preserve the class of the input image)
claheI = I;
claheI(:) = 0;

%compute the LUT for looking up original image values in the tile mappings,
%which we created earlier
if ~(isa(I,'double') || isa(I,'single'))
  k = selectedRange(1)+1 : selectedRange(2)+1;
  aLut = zeros(length(k),1);
  aLut(k) = (k-1)-selectedRange(1);
  aLut = aLut/(selectedRange(2)-selectedRange(1));
else
  % remap from 0..1 to 0..numBins-1
  if numBins ~= 1
    binStep = 1/(numBins-1);
    start = ceil(selectedRange(1)/binStep);
    stop  = floor(selectedRange(2)/binStep);
    k = start+1:stop+1;
    aLut(k) = 0:1/(length(k)-1):1;
  else
    aLut(1) = 0; %in case someone specifies numBins = 1, which is just silly
  end
end

imgTileRow=1;
for k=1:numTiles(1)+1
  if k == 1  %special case: top row
    imgTileNumRows = dimTile(1)/2; %always divisible by 2 because of padding
    mapTileRows = [1 1];
  else 
    if k == numTiles(1)+1 %special case: bottom row      
      imgTileNumRows = dimTile(1)/2;
      mapTileRows = [numTiles(1) numTiles(1)];
    else %default values
      imgTileNumRows = dimTile(1); 
      mapTileRows = [k-1, k]; %[upperRow lowerRow]
    end
  end
  
  % loop over columns of the tileMappings cell array
  imgTileCol=1;
  for l=1:numTiles(2)+1
    if l == 1 %special case: left column
      imgTileNumCols = dimTile(2)/2;
      mapTileCols = [1, 1];
    else
      if l == numTiles(2)+1 % special case: right column
        imgTileNumCols = dimTile(2)/2;
        mapTileCols = [numTiles(2), numTiles(2)];
      else %default values
        imgTileNumCols = dimTile(2);
        mapTileCols = [l-1, l]; % right left
      end
    end
    
    % Extract four tile mappings
    ulMapTile = tileMappings{mapTileRows(1), mapTileCols(1)};
    urMapTile = tileMappings{mapTileRows(1), mapTileCols(2)};
    blMapTile = tileMappings{mapTileRows(2), mapTileCols(1)};
    brMapTile = tileMappings{mapTileRows(2), mapTileCols(2)};

    % Calculate the new greylevel assignments of pixels 
    % within a submatrix of the image specified by imgTileIdx. This 
    % is done by a bilinear interpolation between four different mappings 
    % in order to eliminate boundary artifacts.
    
    normFactor = imgTileNumRows*imgTileNumCols; %normalization factor  
    imgTileIdx = {imgTileRow:imgTileRow+imgTileNumRows-1, ...
                 imgTileCol:imgTileCol+imgTileNumCols-1};

    imgPixVals =I(imgTileIdx{1},imgTileIdx{2});
    
    % calculate the weights used for linear interpolation between the
    % four mappings
    rowW = repmat((0:imgTileNumRows-1)',1,imgTileNumCols);
    colW = repmat(0:imgTileNumCols-1,imgTileNumRows,1);
    rowRevW = repmat((imgTileNumRows:-1:1)',1,imgTileNumCols);
    colRevW = repmat(imgTileNumCols:-1:1,imgTileNumRows,1);
    
    claheI(imgTileIdx{1}, imgTileIdx{2}) = ...
        (rowRevW .* (colRevW .* double(ulMapTile)) + ...
                     colW    .* double(urMapTile)+ ...
         rowW    .* (colRevW .* double(blMapTile)) + ...
                     colW    .* double(brMapTile))...
        /normFactor;
    
    imgTileCol = imgTileCol + imgTileNumCols;    
  end %over tile cols
  imgTileRow = imgTileRow + imgTileNumRows;
end %over tile rows