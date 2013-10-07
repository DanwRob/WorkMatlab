function img=bitreversal(img)
N=length(img);
b=1;
N2=N/2;
for a=2:N
    N1=N2;
    while (b>N1)
        b=b-N1;
        N1=N1/2;
    end
    b=b+N1;
    if a<b
        t1=img(a);
        img(a)=img(b);
        img(b)=t1;
    end
end

