function temp=checkpow2(g)
   [y,x]=size(g);           %saca los valores de width y heigth de la matriz
    
   px=2^ceil(log2(x));      
   py=2^ceil(log2(y));
   temp=zeros(py, px);      %se crea una matriz añadiendo padding de ceros si width y heigth no es potencia de 2 
   temp((1:y),(1:x))=g;     %se tranfieren los valores a la matriz 
   