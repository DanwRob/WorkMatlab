function y=compexp(x,comp,a)

% Compressor/expander from DAFX, Zolzer
% comp	- compression: 0>comp>-1, expansion: 0<comp<1
% a		    - filter parameter <1

h=filter([(1-a)^2],[1.0000 -2*a a^2],abs(x)); %envelope detector filter
h=h/max(h); %normalise filter

h=h.^comp; %apply compression factor
y=x.*h; %apply compression curve to original signal

z=abs(x)-abs(y); % create gain reduction vector for display only

y=y*max(abs(x))/max(abs(y)); %normalise output signal to max of input signal


figure ;
        subplot(1,3,1), plot(x),title('Input'),xlabel('Samples'), ylabel('Amplitude'); 
        subplot(1,3,2), plot(y), title('Output'),xlabel('Samples'), ylabel('Amplitude'); 
        subplot(1,3,3), plot(z), title('Gain Reduction'),xlabel('Samples'), ylabel('Reduction'); 
