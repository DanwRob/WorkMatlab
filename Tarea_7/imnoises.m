function Salida=imnoises(img)% la función se llama imhistogram

idx=unique(img);
Salida=zeros(1, 256);

for i = 1:length(idx)                   %obtencion del histograma
     ind = find(img==idx(i));
     Salida(idx(i)+1)=length(ind);     
end 



        