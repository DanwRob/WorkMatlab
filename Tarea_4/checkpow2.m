function Isalida=checkpow2(g)
   [y,x]=size(g);
   px=log2(x);
   py=log2(y);
   px=2^ceil(px);
   py=2^ceil(py);
   temp=zeros(py, px);
   temp([1:y],[1:x])=g;
   
    Isalida=temp;