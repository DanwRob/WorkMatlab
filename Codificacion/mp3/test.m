[y, Fs, nbits, readinfo] =wavread('monster.wav');
e=y(:,1)-abs(y(:,2));
e2=abs(y(:,1))-abs(y(:,2));
N = length(y);
w = sqrt(2/N);
signal=dct(y(:,1));
x=idct(signal);
f = linspace(0,Fs/2,N)';
figure
subplot 211
plot (f,w*signal);
c=(f<4000);
subplot 212
plot (f,w*c.*signal);
x=signal.*c;

x = idct(x);
% uno=[];
% dos=[];
% uno(:,1)=x;
% uno(:,2)=x+e;
% dos(:,1)=x;
% dos(:,2)=x+e;
sound(x,Fs)
% figure
% subplot 211
% plot(y)
% subplot 212
% plot(signal)