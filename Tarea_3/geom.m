% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 30 de Septiembre 2013
% 
% Tarea No:3
% 
% Titulo: Transformaciones Geometricas
% 
% ------------------------------------------------------------------------

function [Isalida,interSalida]= geom(img,Trans,coordenadas)% la función se llama geomtrans\
Matriz_transformacion=eye(3);%Se crea Matriz de transformaciomn
[y,x]=size(img);
auxx=1;                         %variable para la escala
auxy=1;
error=0;                           %variable de error
q=length(Trans);                    
if q<=3&&q>0                        %comprueba si hay las variables necesarias
    for i=q:-1:1
        if strcmp(Trans(i),'T')==1     %Traslacion     
            Matriz_t=eye(3);
            v=str2num(coordenadas{i});
            Matriz_t(1:2,3)=[v(1),v(2)];       
            Matriz_transformacion= Matriz_t*Matriz_transformacion;  %Matriz afin de traslacion
           
       
        elseif strcmp(Trans(i),'S')==1      %Escalado
            Matriz_s=eye(3);
            v=str2num(coordenadas{i});
            auxx=auxx*v(1);
            auxy=auxy*v(2);
            Matriz_s(1,1)=v(1);
            Matriz_s(2,2)=v(2);
            Matriz_transformacion= Matriz_s*Matriz_transformacion;  %Matriz afin de Escalado
            
        
        elseif strcmp(Trans(i),'R')==1      %Rotacion
             v=str2num(coordenadas{i});
             centro_x=ceil((x/2)*auxx); %se calcula el punto medio
             centro_y=ceil((y/2)*auxy);
             Matriz_r=eye(3);
             Matriz_r(1,:)=[cosd(v(1)),-1*(sind(v(1))),centro_x*(1-cosd(v(1)))+centro_y*(sind(v(1)))];
             Matriz_r(2,:)=[sind(v(1)),cosd(v(1)),centro_y*(1-cosd(v(1)))-centro_x*(sind(v(1)))];
             Matriz_transformacion= Matriz_r*Matriz_transformacion; %Matriz afin de Rotacion
        else
            disp('Error oopcion incorrecta');
            error=1;
        end
        
    end
    M_temp=nan(ceil(y*auxy),ceil(x*auxx)); %se crea la matriz de nan para la salida de la imagen
    if(error==0)
        tic
        
        for i=1:y
            for j=1:x
                 vector=ceil(Matriz_transformacion*[j;i;1]);    %se realiza las coordenadas homogeneas
                if(vector(2)>0&&vector(2)<=ceil(y*auxy)&&vector(1)>0&&vector(1)<=ceil(x*auxx))
                    M_temp(vector(2),vector(1))=img(i,j);           % se trasladan los pixeles a su ubicacion nueva
                end
            end
        end
        toc
            J=M_temp
            N=isnan(J);     %se comprueba los nan existentes en la matriz, para poder interpolarlos
            [yj,xj]=find(~N)
            ind=sub2ind(size(N),yj,xj); %obtiene el index de todos los que no son Nan
            z=J(ind);
            F=TriScatteredInterp(xj,yj,z); %Se interpola los pixeles 
            [qx,qy]=meshgrid(1:x*auxx ,1:y*auxy); % Evalua la interpolacion en las locaciones (qx,qy)
            J2=F(qx,qy);
            J2(isnan(J2))=0; %vuelve 0 a los nan que quedaron
            J2=uint8(fix(J2));  % ajusta a 8 bits
            Isalida=uint8(fix(J));
            interSalida= J2;
    else
        Isalida=M_temp;  %Retona una matriz vacia si hay algun error
        interSalida=M_temp;
    end
end