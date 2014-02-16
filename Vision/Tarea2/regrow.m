% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 15 de Febrero 2014
% 
% Tarea No:2
% 
% Titulo: Segmentacion basada en crecimiento de region
% 
%    I --------Imagen a segmentar
%    S --------Semillas 
%    Q --------Predicados
%    opt ------bandera que se usa para mostrar el proceso, si tiene el valor de 1
%   
%
%   I_s--------Imagen segmentada de salida
%   fQ---------Matriz con todas los objetos segmentados separados
% ------------------------------------------------------------------------

function [I_s,fQ] = regrow(I,S,Q,opt) 
%Inicializar por defecto las variables
if nargin<2
    f=figure;
    imshow(I)
    [px, py] = getpts(f);
    S=zeros(size(I));
    px=round(px);
    py=round(py);
    for i=1:length(px)
    S(py(i),px(i))=255;
    end
end
if nargin<3  
   prompt = {'Predicado Q para la region 1','Predicado Q para la region 2','Predicado Q para la region 3'};
   dlg_title = 'Datos para la funcion';
   num_lines = 1;
   def = {'','',''};
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   Q=str2double(answer);
   opt=1;
   Q(isnan(Q))=[];
    
end


addpath('./Imagenes');

I=mat2gray(I);                  %Convertir la imagen a rango [0-1]
[H,W]=size(I);

I_s=zeros(H,W);
fQ=zeros(H,W,3);                %Matriz de MxNxR donde se guardara cada objeto encontrado
idx=find(S==255);               %Seleccion de las semillas
[idx_Y,idx_X]=find(S==255);    %Coordenadas de las semillas

for Etiqueta=1:length(Q)
    
    Temp=zeros(H,W);          %matriz temporal donde se guardan el objeto encontrado
    miu=I(idx(Etiqueta));       %calcular Miu
    %Inicializar valores
    d=0;                        
    n=1;
    Y=idx_Y(Etiqueta);
    X=idx_X(Etiqueta);
    buffer=ones(10000,3);
    pos=1;
    Temp(Y,X)=Etiqueta;         %se asigna la primera etiqueta
    while(d<Q(Etiqueta))        %Se repite mientras d sea menor que Q

        for y=Y-1:Y+1
            for x=X-1:X+1
              if x>0 && x<=W && y>0 && y<=H && Temp(y,x)==0 && I_s(y,x)==0
                    
                   buffer(pos,:)=[x,y,I(y,x)];      %se ingresan la triada de valor al buffer
                   pos=pos+1;
              end
            end
        end
        buffer=unique(buffer, 'rows');  %se eliminan los repetidos del buffer
        pos=length(buffer(:,1));                % se calcula la nueva posicion a ingresar al buffer
        [d,idx_d]=min(abs(buffer(:,3)-miu));      %se calcula la nueva d, del minimo de la intensidad - miu de los que estan en el buffer
        X=buffer(idx_d,1);
        Y=buffer(idx_d,2);  

        Temp(Y,X)=Etiqueta;                     %se asigna la etiqueta al minimo obtenido.
        n=n+1;                                  %se incrementa n, que es el numero de etiquetas puestas
        buffer(idx_d,:)=[];                     %se saca del buffer el valor minimo obtenido
        index=find(Temp==Etiqueta);
        miu=(sum(I(index)))/n;                   %se calcula la nueva miu 

        if opt==1&&mod(n,100)==0                    %si la opt es 1 muestra como el progreso del crecimiento de region.
            imshow(I,[]); hold on;
            [B,~] = bwboundaries(Temp,'noholes'); 
            for k = 1:length(B)
            boundary = B{k};
            end
            plot(boundary(:,2), boundary(:,1), 'y','LineWidth', 2);
            clear B;
            hold off;
            title('Crecimiento de region en proceso...'); 
            pause(0.001);        
        end

    end
     fQ(:,:,Etiqueta)=Temp;                     %se agregan a la matriz el objeto encontrado
     I_s=I_s+Temp;                              % se unen los objetos en una solo imagen segmentada.
end

 