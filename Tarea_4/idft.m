function Isalida=idft(img)

N=length(img);
g=(0:N-1);
    for k=0:N-1
        Y(k+1)=(1/N)*(sum(img.*(exp((i*2*pi*k.*g)/N))));
        
    end
    Isalida=Y;
