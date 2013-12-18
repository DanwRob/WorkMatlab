function [hist]=cliphist(h,clip,numBins)% la función se llama histequal
%figure
%bar(h);
total=0;
ClipLimit=clip/100;    
clip=round(max(h)*(ClipLimit));

for i=1:numBins
    if h(i)>clip
        total=total+(h(i)-clip);
          h(i)=clip;
    end
end

%distribucion de pixeles cortados
k=1;
while (total~= 0)
   stepSize = max(floor(numBins/total),1);
  for m=k:stepSize:numBins
    if h(m) < clip
      h(m) = h(m)+1;
      total = total - 1; 
      if total == 0
        break;
      end
    end
  end
  
  k = m+1; 
  if k > numBins 
    k = 1;
  end
end
hist=h;
%figure
%bar(hist);







