function [Isalida]= descomprimir(img)
bitstream = fread(img);
binario=fliplr(dec2bin(bitstream));

header=Header(binario(1:8,:));

[simbolos,probabilidades]=Tabla(binario(9:header(3)*4+8,:));
[diccionario,avglen] = huffmandict(simbolos,probabilidades);
%//////////////////////////////////////BitMap////////////////////////////
ini=header(3)*4+8+1;
BitMap1=binario(ini:end,:);
BitMap1=reshape(BitMap1',1,[])';
BitMap1=str2num(BitMap1)';
BitMap1=BitMap1(1:end-header(4));
deco = huffmandeco(BitMap1,diccionario);
equal = isequal(deco,signal);

%////////////////////////////////////////Header//////////////////////////
function header=Header(segmento)
y=(1:2:8);
x=(2:2:8);
Bin=strcat(segmento(y,:),segmento(x,:));
header=bin2dec(Bin);

%//////////////////////////////////////Simbolos//////////////////////////
function [simbolos,probabilidades]=Tabla(segmento)
y=(1:2:length(segmento));
x=(2:2:length(segmento));
simbolos=strcat(segmento(y,:),segmento(x,:));
simbolos=bin2dec(simbolos);
probabilidades=simbolos(header(3)+1:end);
probabilidades=double(probabilidades)/sum(probabilidades);
simbolos=simbolos(1:header(3));
idx=find(32768<simbolos);
simbolos(idx)=simbolos(idx)-65535;
