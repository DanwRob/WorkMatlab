function [ out ] = A( y,n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out=0;
for i=1:n
    out=out+y(i);    
end
end

