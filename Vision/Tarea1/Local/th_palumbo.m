function B = th_palumbo(I,T)

I = double(I);
w = 3;
[An,Ac] = neighboors(w);
[n,m] = size(I);
B = zeros(n,m);

f2 = (3*w-1)/2;

for j = f2+1:m-f2
  for i = f2+1:n-f2
      p = I(i,j);
      if p < T(1)
          B(i,j) = 1;
      else
          sub = I(i-f2:i+f2,j-f2:j+f2);
          subAc = sub(Ac);
          subAn = sub(An);
          idAn = subAn >= T(2);
          mn = mean(subAn(idAn));
          mc = mean(subAc);
          if mn*T(3)+T(5) > mc*T(4)
              B(i,j) = 1;
          end
      end
  end
end

%-----------------------------------------------------------

function [An,Ac] = neighboors(w)
w2 = (w-1)/2;
w3 = 3*w;
K1 = zeros(w3);
K2 = K1;
K1(w2+1,w2+1) = 1;
K1(w2+1,end-w2) = 1;
K1(end-w2,w2+1) = 1;
K1(end-w2,end-w2) = 1;
K2((w3+1)/2,(w3+1)/2) = 1;
B = ones(w);
K1 = imdilate(K1,B,'same');
K2 = imdilate(K2,B,'same');
An = find(K1);
Ac = find(K2);