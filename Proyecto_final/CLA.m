% CLAHE
%
%  Uses similar algorithm to AHE, except clips (by cliplevel) 
%  large values of the pdf to help smooth out areas of constant values.
%
%  Bulk of code is exactly like AHE.  There is a small section that
%  does the clipping.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 1, 2009

function [ out ] = CLA( I, n, cliplevel, windowsize )

% Setup.
r = floor((windowsize-1)/2);
minI = min(min(I));
maxI = max(max(I));
step = (maxI - minI) / (n - 1);

% Original approach.
%cliplevel = cliplevel * n;

H = zeros(n,1);

[height width] = size(I);
out = zeros(height, width);
area = 0;

for j=1:height
    % Find height of addition/subtraction boxes.
    lowj = max(1, j - r);
    highj = min(height, j + r);
    
    % Find height of addition/subtraction boxes.
    for i=(-r+1):(width+r+1)
        % Find the line that is no longer part of our window.
        subi = i - r - 1;

        % Add new line to window.
        addi = i + r;
        
        % Remove pixels on the left edge.
        if ( subi >= 1 )
            % Create histogram, don't scale.
            for jj = lowj:highj
                idx = floor(I(jj, subi) / step) + 1;
                H(idx) = H(idx) - 1;
            end
            % Modify histogram size (for later scaling).
            area = area - (highj - lowj + 1);
        end
        
        % Add pixels on the right edge.
        if ( addi <= width )
            % Create histogram, don't scale.
            for jj = lowj:highj
                idx = floor(I(jj, addi) / step) + 1;
                H(idx) = H(idx) + 1;
            end
            % Modify histogram size (for later scaling).
            area = area + (highj - lowj + 1);
        end
        
        if ( i >= 1 && i <= width )
            % Update pixel value.
            idx = floor(I(j, i) / step) + 1;
            val = 0;
            
            % Crop off the top
            cropped = 0;
            SH = H;
			
			% New clipping routine.
			cliplevel = area * cliplevel;
            for k=1:n
                if ( SH(k) > cliplevel )
                    cropped = cropped + (SH(k) - cliplevel);
                    SH(k) = cliplevel;
                end
            end

            % Spread out the cropped area.  Generate CDF.
            spread = cropped / n;
            for k=1:(idx-1)
                val = val + SH(k) + spread;
            end
            
            % Convert to true CDF value;
            val = (val / area) * (n - 1);
            
            out(j, i) = val;
        end
    end
    
end

% Scale to viewable range.
out = out / n;

end
