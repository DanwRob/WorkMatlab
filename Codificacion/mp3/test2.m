% Load an audio sample data set
[b,R] = wavread ('monster.wav');
N = length(b);
e=b(:,1)-b(:,2);
% Compute the interpolation model coefficients
c = dct(b(:,1));
w = sqrt(2/N);
f = linspace(0,R/2,N)';
windowSize = 8192;
% Lets look at the weighted coefficients and pick a cut-off value
figure
subplot 311
plot (f,w*c)
% Pick a cut-off value and split the coefficients into low- and high-precision sets:
idx=(f<4000);
c=idx.*c;
cutoff = 0.00015
mask = (abs(w*c)<cutoff);
low=mask.*c;
f = linspace(0,R/2,N)';

high=(1-mask).*c;
% This plot nicely illustrates the cut-off region:
subplot 312
plot(f,w*high,'-R',f,w*low,'-b')
% Now pick a precision (in bits) for the low precision data set:
lowbits=8;
% We wont quantize the high-precision set of coefficients (high), only the
% low precision part (requires quantize.m):
low = quantize(low, lowbits);
high = quantize(high, 16);
m = max(abs(high));


y = high/m;
y = (y*(2^8 -1))/2;
y = y*2/(2^8 - 1);
x = y.*m;

subplot 313
plot(f,w*low+high,'-R',f,w*low,'-b')
% Finally, let's reconstruct our compressed audio sample and listen to it!
symbols=unique(high);

[probabilidades,sym]=hist(high,symbols);
% for x=1:length(symbols)
%   probabilidades(x)=numel(find(symbols(x)==high));
% end
probabilidades=double(probabilidades)/numel(high);
[dict,avglen] = huffmandict(symbols,probabilidades');
% qwerty=high(1:1+windowSize-1);
BitMap=cell(length(high),1);
dis=cell2mat(dict(:,1));
for i=1:length(dis)
    indice=(dis(i)==high);
    BitMap(indice)=dict(i,2);
end

% for l=1:windowSize:length(high)
%         temp =  huffmanenco(high(l:l+windowSize-1),dict);
%         BitMap = [BitMap;temp];
% end
%BitMap = huffmanenco(high,dict);

y=idct(low+high);
sound (y,R);
