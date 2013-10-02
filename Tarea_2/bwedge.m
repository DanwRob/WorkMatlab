% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 02 de Octubre 2013
% 
% Tarea No:2
% 
% Titulo: Practica 2.1: Seguimiento de contornos
% 
% ------------------------------------------------------------------------
function Salida=bwedge(Isalida) 
 
[y,x]=size(Isalida);
I = zeros(y+2,x+2);%Se crea una Matriz de ceros
temp=I;
for i = 1:y
        I(i+1,2:end-1) = Isalida(i,:);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
end

Salida = zeros(y,x);            %Se crea una Matriz de ceros para la salida de la imagen


idx = unique(I(:));            % se extrae los indices para identificar las etiquetas iguales
for h = 2:length(idx)           % Se identifican cuantos objetos hay en la imagen y para ir analizando uno a uno
    M_temp=zeros(y,x);          %Se crea una Matriz de ceros temporal para ir añadiendo los contornos encontrados
        ind = I==idx(h);      %se calcula la posicion del primer objeto
        temp(ind)=255;              
        
        d=1;                %almacena la direccion del recorrido del pixel
        flag=0;
        for i=2:y
                for j=2:x

                    if(temp(i,j)~=0) %se busca el primer pixel (P0) apartir de la esquina superior izquierda
                        M_temp(i-1,j-1)=temp(i,j);

                        a=i;
                        b=j;
                        p=[i;j];
                     while(flag~=1)

                             q =mod ((d+3),4);   %Se calcula el q, empieza a buscar en sentido del reloj el primer pixel Pi 
                            switch(q)
                                case 3
                                    if(temp(a+1,b)~=0)%3                
                                       a=a+1;
                                       M_temp(a-1,b-1)=temp(a,b); %se guarda el pixel encontrado

                                       p=[p [a ;b]];
                                       d=3;     %Se actualiza la direccion d apartir de la direccion del recorrido

                                    else
                                        d=1;
                                    end
                                case 0
                                    if(temp(a,b-1)~=0)%0
                                        b=b-1;
                                        M_temp(a-1,b-1)=temp(a,b);  %se guarda el pixel encontrado

                                        p=[p [a ;b]];
                                        d=0;     %Se actualiza la direccion d apartir de la direccion del recorrido

                                    else
                                        d=2;
                                    end
                                case 1
                                    if(temp(a-1,b)~=0)%1
                                        a=a-1;
                                        M_temp(a-1,b-1)=temp(a,b);  %se guarda el pixel encontrado

                                        p=[p,[a ;b]];
                                        d=1;     %Se actualiza la direccion d apartir de la direccion del recorrido

                                    else
                                        d=3;
                                    end
                                case 2
                                    if(temp(a,b+1)~=0)%2
                                        b=b+1;
                                        M_temp(a-1,b-1)=temp(a,b);  %se guarda el pixel encontrado

                                        p=[p,[a ;b]];
                                        d=2;     %Se actualiza la direccion d apartir de la direccion del recorrido

                                    else
                                        d=0;
                                    end                            
                            end

                            if(length(p(1,:))>2) %Si el píxel actual Pi es igual al segundo elemento del borde P1 y si el elemento previo Pi-1
                                                 %es igual al punto inicial del borde P0 entonces terminar el algoritmo
                                if(p(:,end-1)==p(:,1) )
                                    if(p(:,end)==p(:,2))
                                        flag=1;
                                    end
                                end
                            end

                     end


                    end
                     
                     if(flag==1)%2
                         Salida=Salida+M_temp;   %Se añaden los contornos del objeto encontrado a la matriz de salida
                        break;
                     end
                end
                if(flag==1)%2
                        break;
                end
        end
    temp = zeros(y+2,x+2);
       
end



