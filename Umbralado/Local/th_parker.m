function [ outputImage ] = th_parker( inputImage, b, k, m0, s0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  inputImage=double(inputImage);
  I=inputImage;
  kernelMedias = ones(b,b);
  % kernel de medias y kernel de Standar Desviation (SD)
  kernelSD=kernelMedias;  
  kernelMedias = (1/(b*b)) .* kernelMedias;  
  V=[-1,-1;-1,0;-1,+1;0,-1;0,+1;+1,-1;+1,0;+1,+1];
  
  for i=2:255
      for j=2:255
          min=I(i,j);
          for k=1:8
              min2=I(i,j) - I(i+V(k,1),j+V(k,2));
              if (min2<min)
                  min=min2;
              end
          end
          D(i,j)=min;
      end
  end
        % aplico el filtro de medias
        M = imfilter(D,kernelMedias,'replicate');
        % aplico el filtro de SD
        S=stdfilt(D,kernelSD);  
        
        for i=1:255;
            for j=1: 255
                if M(i,j)>=m0 | S(i,j)<s0
                    I(i,j)=0;
                else if 
                    end
                end
            end
        end
        
        
        
end

