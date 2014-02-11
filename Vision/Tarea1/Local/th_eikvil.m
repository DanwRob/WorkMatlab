function B = th_eikvil(I,t)
% Si la imagen no es de dimensiones impares elimina el ultimo renglon y/o
% columna
[N,M] = size(I);
if mod(N,2) == 0
   I(end,:) = []; 
   N = N-1;
end
if mod(M,2) == 0
    I(:,end) = [];
    M = M-1;
end

% Genera la secuencia de barrido en zig-zag
Grid = zeros(N,M);
Grid(7:end-6,7:end-6) = 1;
Grid(1:2:N,:) = 0;
Grid(:,1:2:M) = 0;
LGrid = bwlabel(Grid')';
LGrid(10:4:end,:) = fliplr(LGrid(10:4:end,:));
NumEts = max(LGrid(:));
B = zeros(N,M);

% Proceso de umbralado
for k = 1:NumEts
   [m,n] = find(LGrid == k);
   S = I(m-1:m+1,n-1:n+1);
   L = I(m-7:m+7,n-7:n+7);
   T = 255*graythresh(L);
   L = double(L);
   BL = L >= T;
   m1 = mean(L(BL));
   m2 = mean(L(~BL));
      
   if abs(m1-m2) >= t
       BS = S>=T;
   else
       ms = mean2(S);
       [~,ind] = min([abs(m1-ms) abs(m2-ms)]);
       if ind == 1
           BS = ones(3);
       else
           BS = zeros(3);
       end
   end
   B(m-1:m+1,n-1:n+1) = BS;
end
B = ~B(7:end-6,7:end-6);