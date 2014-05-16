function gaus=Gauss(r)
n=1+2^r;
[X,Y] = meshgrid(1:n, 1:n);
centro=ceil(n/2);
gaus=2.^(abs(Y-centro)+abs(X-centro)-1);
gaus=1./gaus;
gaus(centro,centro)=0;
