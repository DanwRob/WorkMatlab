function Isalida= geomtrans(img,Trans,coordenadas)% la función se llama geomtrans\
Matriz_transformacion=eye(3);
[y,x]=size(img);
M_temp=zeros(y,x);
 
if strcmp(Trans,'T')==1
 v=str2num(coordenadas{1});
 Matriz_transformacion(1:2,3)=[v(1),v(2)]

    for i=1:y
        for j=1:x
            
            vector=Matriz_transformacion*[j;i;1];
            if(vector(2)>=0&&vector(2)<=y&&vector(1)>=0&&vector(1)<=x)
            M_temp(vector(2),vector(1))=img(i,j);
            end
            
         
        end
    end
   
    Isalida= M_temp;
    
elseif strcmp(Trans,'S')==1
 v=str2num(coordenadas{2});
 Matriz_transformacion(1,1)=v(1);
 Matriz_transformacion(2,2)=v(2);

     for i=1:y
        for j=1:x
            
            vector=Matriz_transformacion*[j;i;1];
            if(vector(2)>0&&vector(2)<=y&&vector(1)>0&&vector(1)<=x)
            M_temp(vector(2),vector(1))=img(i,j);
            end
            
         
        end
    end
   
    Isalida= M_temp;
elseif strcmp(Trans,'R')==1
 v=str2num(coordenadas{3});
 v(1)
 centro_x=ceil(x/2)
 centro_y=ceil(y/2)


 
        Matriz_transformacion(1,:)=[cosd(v(1)),sind(v(1))*-1,centro_x*(1-cosd(v(1)))+centro_y*(sind(v(1)))]
        Matriz_transformacion(2,:)=[sind(v(1)),cosd(v(1)),centro_y*(1-cosd(v(1)))-centro_x*(sind(v(1)))]
    
 for i=1:y
        for j=1:x
            
            vector=Matriz_transformacion*[j;i;1];
            vector=ceil(vector);
            if(vector(2)>0&&vector(2)<=y&&vector(1)>0&&vector(1)<=x)
            M_temp(vector(2),vector(1))=img(i,j);
            end
            
         
        end
 end
   
    Isalida= M_temp;

 
    
end
