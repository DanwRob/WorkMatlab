function [ Isalida,Isalida_ruido ] = descompresor2( img )
   
    bitstream = fread(img);
    binario=fliplr(dec2bin(bitstream));

    %///////////////////////////////Header////////////////////////////////
    header=binario(1:6,:);
    y=(1:2:6);
    x=(2:2:6);
    Bin=strcat(header(y,:),header(x,:));
    header=bin2dec(Bin);
    tamano_valor=binario(7:10,:);
    tamano_valor=reshape(tamano_valor',1,[]);
    tamano_valor=bin2dec(tamano_valor);
    
    %/////////////////////////////Body//////////////////////////////////
    body=binario(11:end,:);
    body=reshape(body',1,[])-'0';
    Valores=body(1:tamano_valor);
    final=tamano_valor*header(3)+tamano_valor;
    REpetidos=body(1,tamano_valor+1:final);
    REpetidos=reshape(REpetidos,header(3),[])';
    REpetidos=bin2dec(num2str(REpetidos))';

    Isalida=zeros(1,header(1)*header(2)*8);
    %////////////////////////////añadir ruido//////////////////////////
     U = rand(1,header(1)*header(2)*8);
     Isalida_ruido=zeros(size(U));
     idx= U>0.5&U<=0.5+0.5;      
     Isalida_ruido(idx)=1;    
    
    c=1;
    for i=1:length(Valores)
       Isalida(c:c+REpetidos(i)-1)=Valores(i);
       c=c+REpetidos(i);
    end
    Isalida=reshape(Isalida,header(1),header(2),[]);
    
    Isalida_ruido(1:c-1)=Isalida(1:c-1);
    
    
    %////////////////////////////formar imagen////////////////////////
    
    Isalida=reshape(Isalida,header(1)*header(2),8);
    Isalida_ruido=reshape(Isalida_ruido,header(1)*header(2),8);
    Isalida=num2str(Isalida);
    Isalida_ruido=num2str(Isalida_ruido);
    Isalida=bin2dec(Isalida);
    Isalida_ruido=bin2dec(Isalida_ruido);
    Isalida=uint8(reshape(Isalida,header(1),header(2)));
    Isalida_ruido=uint8(reshape(Isalida_ruido,header(1),header(2)));
end

