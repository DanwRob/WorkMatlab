% ------------------------------------------------------------------------
% --------- P R O C E S A M I E N T O   D E   I M A G E N E S ------------
% ------------------------------------------------------------------------
%
% Dan Williams Robledo Cruz
% 
% 01 de Octubre 2013
% 
% Tarea #1
% 
% Leer un archivo BMP con color indexado de 8-bits
% 
%
% ------------------------------------------------------------------------


function [Isalida,flag]= readbmp(img)% la función se llama readbmp

x = fread(img);%Lee la imagen y se guarda la informacion en un vector columna

bfType =x(1:2);% se saca el bfType para saber si es un archivo BMP
BMP=bin2dec([dec2bin(bfType(2),8) dec2bin(bfType(1),8)]);%conversion de decimal a binario se concatena los valores y se pasa de binario a decimal, para obtener el valor real

biBitCount=x(29:30);% se saca el biBitCount para saber si es un archivo de 8 bits
biBitCount=bin2dec([dec2bin(biBitCount(2),8) dec2bin(biBitCount(1),8)]);%conversion de decimal a binario se concatena los valores y se pasa de binario a decimal, para obtener el valor real


if(BMP==19778)%Es BMP continua
     
    if(biBitCount==8)%Es de 8 bits continua
        
        bfOffBits= fliplr(x(11:14)');% Rango de valores de bfOffBits 
        temp_bfOffBits=dec2bin(bfOffBits,8);
        bfOffBits=bin2dec( [temp_bfOffBits(1,:) temp_bfOffBits(2,:) temp_bfOffBits(3,:) temp_bfOffBits(4,:)]);%Valor  para conocer donde inicia el BitMap
    
        biWidth=fliplr(x(19:22)');%Rango de ancho en pixeles de la imagen
        w=dec2bin(biWidth,8);
        biWidth=bin2dec( [w(1,:) w(2,:) w(3,:) w(4,:)]);% valor real de lo ancho

        biHeigth=fliplr(x(23:26)');%Rango de alto en pixeles de la imagen
        h=dec2bin(biHeigth,8);
        biHeigth=bin2dec( [h(1,:) h(2,:) h(3,:) h(4,:)]);%valor real de lo alto
        

        biClrUsed=fliplr(x(47:50)');%Rango del biClrUsed
        temp_biClrUsed=dec2bin(biClrUsed,8);
        biClrUsed=bin2dec( [temp_biClrUsed(1,:) temp_biClrUsed(2,:) temp_biClrUsed(3,:) temp_biClrUsed(4,:)]);%Valor de biClrUseda

        ColorMap = x(55:bfOffBits); %Paleta de colores
        BitMap = x(bfOffBits+1:end); %Mapa de Bits

        if(mod(biWidth,4)~=0)
            pad=4-mod(biWidth,4);
        else
            pad=0;
        end
        
         %Determina si existe padding en el Mapa de Bits
        k=1;
        I = zeros(biHeigth,biWidth);%Se crea una Matriz de ceros

         for i = 1:biHeigth
            I(i,:) = BitMap(k:k+biWidth-1);% Extrae el BitMap y se pasa al Nuevo BitMap
            k = k+biWidth+pad;
        end
        I = flipud(I);% Se invierte el BitMap

        if(biClrUsed==236)% Determina si es una imagen a color
            b = ColorMap(1:4:end); %Extrae la paleta de color para el Azul
            g = ColorMap(2:4:end); % Extrae la paleta de color para el Verde
            r = ColorMap(3:4:end); % Extrae la paleta de color para el Rojo
           MAP = [r g b]/255;%  Genera la matriz de la paleta de colores

           R = zeros(biHeigth,biWidth); % Matrices auxiliares RGB
            G = R; B = R;
            idx = unique(I(:));   % Determina cuáles índices existen
            for i = 1:length(idx)
                ind = I==idx(i);   % Extrae los índices con valor igual
                R(ind) = MAP(idx(i)+1,1);% Transfiere la información del rojo
                G(ind) = MAP(idx(i)+1,2); % Transfiere la información del verde
                B(ind) = MAP(idx(i)+1,3); % Transfiere la información del azul
            end
                Isalida = zeros(biHeigth,biWidth,3);
                Isalida(:,:,1) = R;   % Transfiere las matrices a la imagen de
                Isalida(:,:,2) = G;  % salida
                Isalida(:,:,3) = B;
        else
           Isalida=I;% salidade escala de grises

        end
        flag=1;
        
    else% Error si la imagen no es de 8 bits
    Isalida='No es una imagen de 8 bits'
    flag=0;  
    end
    
else% Error si la imagen no es BMP
    Isalida='No es una imagen de BMP'
    flag=0;
end

