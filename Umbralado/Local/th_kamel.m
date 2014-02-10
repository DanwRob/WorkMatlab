function B = th_kamel(I,b,T0)

I = double(I);
w = 2*b+1;          % Tamano de ventana
h = ones(w)/w^2;
J = conv2(I,h,'same');  % Matriz de medias locales

% Determina los indices de los 8 vecinos
r = [b b b*(2*b-1) 2*b b*(2*b-1) b b];
p = zeros(1,8); p(1) = 1;
for i = 2:8
   p(i) = p(i-1)+r(i-1); 
end
% Indices que corresponden con los pixeles de interes P0,P1,...,P7
% Se ordenan de acuerdo al barrido de la comparacion con el pixel central
P = [p(2) p(7) p(1) p(8);
     p(1) p(8) p(4) p(5);
     p(4) p(5) p(6) p(3);
     p(6) p(3) p(7) p(2)];

% Proceso de umbralado
w2 = (w-1)/2;
[M,N] = size(I);
B = zeros(M,N);
for i = w2+1:M-w2
   for  j = w2+1:N-w2
       sub = J(i-w2:i+w2,j-w2:j+w2);
       L = sub(P) - I(i,j) >= T0;
       if max(min(L,[],2))
           B(i,j) = 1;
       end
   end
end