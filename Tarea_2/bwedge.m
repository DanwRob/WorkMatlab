function Salida=bwedge(Isalida) 
 temp=Isalida;
[y,x]=size(temp);
I = zeros(y+2,x+2);%Se crea una Matriz de ceros

for i = 1:y
        I(i+1,2:end-1) = temp(i,:);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
end

Salida = zeros(y,x);%Se crea una Matriz de ceros


d=1;
flag=0;

for i = 2:y
        for j=2:x
            
            if(I(i,j)~=0)
                Salida(i-1,j-1)=I(i,j);
               
                a=i;
                b=j;
                p=[i;j];
             while(flag~=1)
                 
                     q =mod ((d+3),4);
                    switch(q)
                        case 3
                            if(I(a+1,b)~=0)%3                
                               a=a+1;
                               Salida(a-1,b-1)=I(a,b);
                               
                               p=[p [a ;b]];
                               d=3;
                               
                            else
                                d=1;
                            end
                        case 0
                            if(I(a,b-1)~=0)%0
                                b=b-1;
                                Salida(a-1,b-1)=I(a,b);
                                
                                p=[p [a ;b]];
                                d=0;
                                
                            else
                                d=2;
                            end
                        case 1
                            if(I(a-1,b)~=0)%1
                                a=a-1;
                                Salida(a-1,b-1)=I(a,b);
                                
                                p=[p,[a ;b]];
                                d=1;
                                
                            else
                                d=3;
                            end
                        case 2
                            if(I(a,b+1)~=0)%2
                                b=b+1;
                                Salida(a-1,b-1)=I(a,b);
                                
                                p=[p,[a ;b]];
                                d=2;
                                
                            else
                                d=0;
                            end                            
                    end
                    
                    if(length(p(1,:))>2)
                        if(p(:,end-1)==p(:,1) )
                            if(p(:,end)==p(:,2))
                                flag=1;
                            end
                        end
                    end
                   
             end
                
                
            end
             if(flag==1)%2
                break;
             end
        end
        if(flag==1)%2
                break;
        end
end
%p;
 %Salida
