function Isalida= geom(img,Trans,coordenadas)% la función se llama geomtrans\
Matriz_transformacion=eye(3);
length(coordenadas);

[y,x]=size(img);
M_temp=zeros(y,x);
q=length(Trans);
if q<=3&&q>0
    for i=q:-1:1
        if strcmp(Trans(i),'T')==1           
            Matriz_t=eye(3);
            v=str2num(coordenadas{i});
            Matriz_t(1:2,3)=[v(1),v(2)];
            Matriz_transformacion= Matriz_t*Matriz_transformacion;
           
        end
        if strcmp(Trans(i),'S')==1
            Matriz_s=eye(3);
            v=str2num(coordenadas{i});
            Matriz_s(1,1)=v(1);
            Matriz_s(2,2)=v(2);
            Matriz_transformacion= Matriz_s*Matriz_transformacion;
            
        end
        if strcmp(Trans(i),'R')==1
             v=str2num(coordenadas{i});
             centro_x=ceil(x/2);
             centro_y=ceil(y/2);
             Matriz_r=eye(3);
             Matriz_r(1,:)=[cosd(v(1)),sind(v(1))*-1,centro_x*(1-cosd(v(1)))+centro_y*(sind(v(1)))];
             Matriz_r(2,:)=[sind(v(1)),cosd(v(1)),centro_y*(1-cosd(v(1)))-centro_x*(sind(v(1)))];
             Matriz_transformacion= Matriz_r*Matriz_transformacion;
        end
        
    end
    for i=1:y
        for j=1:x
             vector=ceil(Matriz_transformacion*[j;i;1]);
            if(vector(2)>0&&vector(2)<=y&&vector(1)>0&&vector(1)<=x)
            M_temp(vector(2),vector(1))=img(i,j);
            end
        end
    end
   J=zeros(y+2,x+2);
   for i = 1:y
        J(i+1,2:end-1) = M_temp(i,:);% Se Extrae la Matriz de la imagen agregando un paddin de 0
            
   end
   for i=1:y
        for j=1:x
            if( M_temp(i,j)==0) 
            M_temp(i,j)=(J(i+1,j)+J(i+1,j+2)+J(i,j+1)+J(i+2,j+1))/4;
            end
        end
    end
    
    
        J=M_temp;
        N=isnan(J)
		[yj,xj]=find(~N);
		ind=sub2ind(size(N),yj,xj);
		z=J(ind);
		F=TriScatteredInterp(xj,yj,z);
		[qx,qy]=meshgrid(-2:.25:2 ,-2:.25:2);
		J2=F(qx,qy);
		J2(isnan(J2))=0;
		J2=uint8(fix(J2));
		J=uint8(fix(J));
    Isalida= J;
end


   

