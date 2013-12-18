function [hist]=histequal(h,clip,numBins)% la funci�n se llama histequal
totalExcess = sum(max(h - clip,0));  
total=0;
ClipLimit=clip/100;    
clip=max(h)*(ClipLimit);

for i=1:numBins
    if h(i)>clip
        total=total+(h(i)-round(clip));
          h(i)=round(clip);
    end
end
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
  
  k = k+1; 
  if k > numBins 
    k = 1;
  end
end
hist=h;







