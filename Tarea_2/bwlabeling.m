function Salida= bwlabeling(Isalida)
 Salida=Isalida;
[y,x]=size(Salida);
I = zeros(y+1,x+1);%Se crea una Matriz de ceros

for i = 1:y
        I(i+1,2:end) = Salida(i,:);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
end

Ne=0;

tabla=[0,0];
for i = 2:y+1
        for j=2:x+1
            lx=I(i,j);
            if(lx~=0)
                if(I(i,j-1)==0&&I(i-1,j)==0)
                    Ne=Ne+1;
                    lx=Ne;
                    I(i,j)=lx;
                elseif(I(i,j-1)~=I(i-1,j)&&I(i,j-1)~=0&&I(i-1,j)~=0)
                    tabla=[tabla;I(i-1,j),I(i,j-1)];
                    lx=I(i,j-1);
                    I(i,j)=lx;
                elseif(I(i,j-1)~=0)
                    lx=I(i,j-1);
                    I(i,j)=lx;
                elseif(I(i-1,j)~=0)
                    lx=I(i-1,j);
                    I(i,j)=lx;
                end
                
               
            end
        end
end

for i = 1:y
        Salida(i,:)= I(i+1,2:end);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
end
clases=1:Ne;

b=eye(length(clases));
aux=length(tabla(:,1));

for i=2:aux
    b(tabla(i,1),tabla(i,2))=1;
    b(tabla(i,2),tabla(i,1))=1;
end
Bm=zeros(length(clases));
for i=1:length(clases)
    for j=1:length(clases)
        if(b(i,j)==1)
            for k=1:length(clases)
               
                Bm(i,k)=b(i,k)|b(k,j);
                
            end
        end
    end
end
for i=1:length(clases)
    for j=1:length(clases)
        if(Bm(i,j)==1)
        clases(j)=clases(i);
        end
    end
end
idx = unique(Salida(:));
for i = 2:length(idx)
        ind = Salida==idx(i);
        Salida(ind)=clases(i-1);
end