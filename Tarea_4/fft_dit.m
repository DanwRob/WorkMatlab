function Isalida=fft_dit(g)

N=length(g);
 d=log2(length(g));
 d=2^(d-1);

   for pass=1:3
     w=exp(-1*((i*2*pi)/(2*d)));
     for b=0:d-1
         a=0;
        while(a<N)
         t0=g(b+a+1)+g(b+d+a+1);
         t1=(w^(b))*(g(b+a+1)-g(b+d+a+1));
         g(b+a+1)=t0;
         g(b+d+a+1)=t1;
         a=a+2*d;
        end
     end
      
      d=d/2;
  end 
    Isalida=g;