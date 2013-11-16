function Hp=freqlap(I)
[Y,X]=size(I);                      %se obtiene el tamaño de la imagen
[M,N]=meshgrid(0:Y-1,0:X-1);
F=I.*((-1).^(M+N));                 %se obtiene el tamaño de la imagen
F=fft2(F);                          %se aplica la transformada de fourier

[V,U]=meshgrid(0:Y-1,0:X-1);
H=-((V-(Y/2)).^2+(U-(X/2)).^2);     %Se calcula el Filtro Laplaciano
Hp=H.*F;                            %Se multiplica el filtro por la transformada de Fourier
Hp=abs(ifft2(Hp));                  % se aplica la inversa de la trasformada de fourier






