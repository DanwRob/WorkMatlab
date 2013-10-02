function Salida= bwlabeling(Isalida)
 Salida=Isalida;
[y,x]=size(Salida);
I = zeros(y+1,x+1);%Se crea una Matriz de ceros

for i = 1:y
        I(i+1,2:end) = Salida(i,:);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
end

Ne=0;                               %Numero de etiquetas

tabla=[0,0];                        %tabla de equivalencias
for i = 2:y+1                       %Propagacion de las etiquetas para conectividad 4
        for j=2:x+1
            lx=I(i,j);
            if(lx~=0)               %cuando lx=0 pasa al siguiente pixel
                if(I(i,j-1)==0&&I(i-1,j)==0)        %si el pixel superior y el pixel izquierdo es 0, se agrega nueva etiqueta
                    Ne=Ne+1;
                    lx=Ne;
                    I(i,j)=lx;                      %Se pone la etiqueta en la matriz de la imagen
                elseif(I(i,j-1)~=I(i-1,j)&&I(i,j-1)~=0&&I(i-1,j)~=0) %se comprueba que el pixel superior y el izquierdo sea diferente y diferente a 0
                    tabla=[tabla;I(i-1,j),I(i,j-1)];        %Se añade a la tabla de equivalencia la relacion entre el pixel superior e izquierdo
                    lx=I(i,j-1);                            
                    I(i,j)=lx;                              %Se pone la etiqueta en la matriz de la imagen
                elseif(I(i,j-1)~=0)                         %Si el pixel izquierdo es diferente de 0 se añade la etiqueta del pixel izquierdo a pixel actual
                    lx=I(i,j-1);
                    I(i,j)=lx;
                elseif(I(i-1,j)~=0)                         %Si el pixel superior es diferente de 0 se añade la etiqueta del pixel superior a pixel actual
                    lx=I(i-1,j);
                    I(i,j)=lx;
                end
                
               
            end
        end
end

for i = 1:y
        Salida(i,:)= I(i+1,2:end);% Se Extrae la Matriz de la imagen quitandole el padding agregado
            
end
clases=1:Ne;                       %Se determinan las clases de equivalencia

b=eye(length(clases));              %apartir de los pares de equivalencia se genera la matriz binaria b
aux=length(tabla(:,1));

for i=2:aux
    b(tabla(i,1),tabla(i,2))=1;     %b se convierte en reflexiva y simetrica
    b(tabla(i,2),tabla(i,1))=1;
end
Bm=zeros(length(clases));           
for i=1:length(clases)
    for j=1:length(clases)
        if(b(i,j)==1)
            for k=1:length(clases)
               
                Bm(i,k)=b(i,k)|b(k,j);  %se resuelve la tabla de equivalancia con el algoritmo de Warshall
                
            end
        end
    end
end
for i=1:length(clases)
    for j=1:length(clases)
        if(Bm(i,j)==1)
        clases(j)=clases(i);            %Apartir de Bm se determinan las clases de equivalencias.
        end
    end
end
idx = unique(Salida(:));
for i = 2:length(idx)
        ind = Salida==idx(i);
        Salida(ind)=clases(i-1);        %se sustitiyen las etiquetas equivalentes en la matriz de salida de la imagen
end