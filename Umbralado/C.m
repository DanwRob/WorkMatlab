function [ out ] = C( y , n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

out=0;
for i=1:n
    out=out+(y(i) * i^2);
end
end

