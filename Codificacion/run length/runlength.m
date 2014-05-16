function [idx,repetidos]=runlength(matriz)

vector=reshape(matriz,1,[]);
 
c=1;
relMat = [];
for i=1:length(vector)-1
   if vector(i)==vector(i+1)
       c=c+1;
   else
       valor = vector(i);
       longitud =  c;
       relMat = [relMat; valor longitud];
       c = 1;
   end
    
end
valor = vector(end);
longitud =  c;
relMat = [relMat; valor longitud];
idx=relMat(:,1);
repetidos=relMat(:,2);