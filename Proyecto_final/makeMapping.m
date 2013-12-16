% Calculate the equalized lookup table (mapping) based on cumulating the input 
% histogram.  Note: lookup table is rescaled in the selectedRange [Min..Max].

function mapping = makeMapping(imgHist, selectedRange, fullRange, ...
                               numPixInTile, distribution, alpha)

mapping = zeros(size(imgHist));
histSum = cumsum(imgHist);
valSpread  = selectedRange(2) - selectedRange(1);

switch distribution
 case 'uniform',
  scale =  valSpread/numPixInTile;
  mapping = min(selectedRange(1) + histSum*scale,...
                selectedRange(2)); %limit to max
  
 case 'rayleigh', % suitable for underwater imagery
  % pdf = (t./alpha^2).*exp(-t.^2/(2*alpha^2))*U(t)
  % cdf = 1-exp(-t.^2./(2*alpha^2))
  hconst = 2*alpha^2;
  vmax = 1 - exp(-1/hconst);
  val = vmax*(histSum/numPixInTile);
  val(val>=1) = 1-eps; % avoid log(0)
  temp = sqrt(-hconst*log(1-val));
  mapping = min(selectedRange(1)+temp*valSpread,...
                selectedRange(2)); %limit to max
  
 case 'exponential',
  % pdf = alpha*exp(-alpha*t)*U(t)
  % cdf = 1-exp(-alpha*t)
  vmax = 1 - exp(-alpha);
  val = (vmax*histSum/numPixInTile);
  val(val>=1) = 1-eps;
  temp = -1/alpha*log(1-val);
  mapping = min(selectedRange(1)+temp*valSpread,selectedRange(2));
  
 otherwise,
  eid = sprintf('Images:%s:internalError', mfilename);
  msg   = 'Unknown distribution type.'; %should never get here
  error(eid, msg);
  
end

%rescale the result to be between 0 and 1 for later use by the GRAYXFORM 
%private mex function
mapping = mapping/fullRange(2);