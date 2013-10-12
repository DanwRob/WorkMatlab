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

function Salida=imgraytrans(img,Trans,valores)% la función se llama geomtrans\

 
 
        if strcmp(Trans,'lin')==1
           v=str2num(valores{1})%Traslacion     
           Salida=v(1).*img+v(1);
        elseif strcmp(Trans,'neg')==1      %Escalado
           Salida=255-img;
        elseif strcmp(Trans,'log')==1
             rmax=255;
             v=str2num(valores{1});
             c=255/log(1+rmax)
             Salida=c.*log(1+(exp(v)-1).*img);
            
        elseif strcmp(Trans,'exp')==1
       
             rmax=max(max(img));
             v=str2num(valores{1});
             c=255/log(1+rmax)
             Salida=c.*(((1+v).^img)-1);
             
         elseif strcmp(Trans,'gamma')==1
             rmax=max(max(img));
             v=str2num(valores{1});
             c=255/log(1+rmax);
             
             
         elseif strcmp(Trans,'norm')==1
              Salida=4
        else
            disp('Error oopcion incorrecta');
            Salida=1;
        end
        
