function bitstream=compresor(I,capas)

[H,W]=size(I);

datos=dec2bin(I,8);
datos=datos-'0';
datos=reshape(datos,H,[],8);
valor=[];redundancia=[];


for i=1:capas
[idx,repetidos]=runlength(datos(:,:,i));
valor=[valor;idx];
redundancia=[redundancia;repetidos];
end
redundancia=dec2bin(redundancia)-'0';
[~,tamano_redun]=size(redundancia);
tamano_v=length(valor);
redundancia=reshape(redundancia',1,[]);
tamano_v=dec2bin(tamano_v,32)-'0';

header=[H,W,tamano_redun];
header=dec2bin(header,16)-'0';
header=reshape(header',1,[]);
header=[header,tamano_v];

bitstream=[header,valor',redundancia];
%//////////////////////////////////padding////////////////////////
padding=mod(length(bitstream),8);
if(padding~=0)
    padding_bitstream=8-padding;
    V_padding=zeros(1,padding_bitstream);
    bitstream=[bitstream V_padding];
end


