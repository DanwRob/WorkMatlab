function y = quantize (x, bits)
m = max(abs(x));
y = x/m;
y = floor((2^bits - 1)*y/2);
y = 2*y/(2^bits -1);
y = m*y;
