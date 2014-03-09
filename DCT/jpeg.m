
zigzag=[1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6 7 14 21 28 35 42 49 57 50 43 36 29 22 15 8 16 23 30 37 44 51 58 59 52 45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64]; 

I=imread('cameraman.tif');
[Heigth,Width]=size(I);

fun=@(block_struct)cdt2(block_struct.data,zigzag);
signal=blockproc(I,[8 8],fun,'PadPartialBlocks',true);

signal=reshape(signal',1,[]);

symbols=unique(signal);
probabilidades=symbols;
for x=1:length(symbols)
  probabilidades(x)=numel(find(symbols(x)==signal));
end
b_prob=dec2bin(probabilidades,16);
b_prob=reshape(b_prob',1,[]);

probabilidades=double(probabilidades)/numel(signal);
[dict,avglen] = huffmandict(symbols,probabilidades);
BitMap = huffmanenco(signal,dict);
%deco = huffmandeco(BitMap,dict);
%equal = isequal(signal,deco); 
idx=find(symbols<0);
b_symbols=abs(symbols);
b_symbols=dec2bin(b_symbols,16);
A1=ones(1,16);
for i=1:length(idx)
    num= str2num(b_symbols(idx(i),:)')';
    complemento=(num2str(xor(num, A1)));
    complemento=complemento(isspace(complemento)==0);
    b_symbols(idx(i),:)=complemento;
end
longitud_BitMap=length(BitMap);
longitud_symbols=length(b_symbols);
b_symbols=reshape(b_symbols',1,[]);

%/////////////////////////////////ajuste del BitMap/////////////////
padding=mod(longitud_BitMap,8);
if(padding~=0)
    padding_BitMap=8-padding;
    V_padding=zeros(1,padding_BitMap);
    BitMap=[BitMap V_padding];
end

%/////////////////////////////////construcción del header/////////////////
header=[Heigth,Width,longitud_symbols,padding_BitMap]
header=dec2bin(header,16);
header=reshape(header',1,[]);


%///////////////////////////construcción del bitstream//////////////////
bitstream=strcat(header,b_symbols,b_prob);
bitstream=reshape(bitstream',1,[]);
bitstream=[str2num(bitstream')' BitMap];
fid = fopen('out.dna', 'w');
fwrite(fid, bitstream,'ubit1'); 


i1 = fopen('out.dna','r');
bitstream = fread(i1);
binario=fliplr(dec2bin(bitstream));
%////////////////////////////////////////Header//////////////////////////
header=binario(1:8,:);
y=(1:2:8);
x=(2:2:8);
Bin=strcat(header(y,:),header(x,:));
header=bin2dec(Bin);

%//////////////////////////////////////Simbolos//////////////////////////
diccionario=binario(9:header(3)*4+8,:);
y=(1:2:length(diccionario));
x=(2:2:length(diccionario));
simbolos=strcat(diccionario(y,:),diccionario(x,:));
simbolos=bin2dec(simbolos);
probabilidades=simbolos(header(3)+1:end);
probabilidades=double(probabilidades)/sum(probabilidades);
simbolos=simbolos(1:header(3));
idx=find(32768<simbolos);
simbolos(idx)=simbolos(idx)-65535;
[diccionario,avglen] = huffmandict(simbolos,probabilidades);
%//////////////////////////////////////BitMap////////////////////////////
ini=header(3)*4+8+1;
BitMap1=binario(ini:end,:);
BitMap1=reshape(BitMap1',1,[])';
BitMap1=str2num(BitMap1)';
%equal = isequal(BitMap,BitMap1); 
%padding=length(BitMap1)-header(4);
BitMap1=BitMap1(1:end-header(4));
deco = huffmandeco(BitMap1,dict);
equal = isequal(deco,signal); 
