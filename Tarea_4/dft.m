function Isalida=dft(img)

N=length(img);
g=(0:N-1);
    for k=0:N-1
        Y(k+1)=sum(img.*(exp(-1*((i*2*pi.*g.*k)/N))));
        
    end
    Isalida=Y;