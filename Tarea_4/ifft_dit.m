function g=ifft_dit(g)

N=length(g);
 dx=log2(N);
 delta=2^(dx-1);

   for pass=1:dx
     w=exp(((1i*2*pi)/(2*delta)));
     for b=0:delta-1
         a=0;
        while(a<N)
         t0=g(b+a+1)+g(b+delta+a+1);
         t1=(w^b)*(g(b+a+1)-g(b+delta+a+1));
         g(b+a+1)=t0;
         g(b+delta+a+1)=t1;
         a=a+2*delta;
        end
     end
      
      delta=delta/2;
   end 
  
   g=g/N;