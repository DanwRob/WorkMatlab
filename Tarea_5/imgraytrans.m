% ------------------------------------------------------------------------
% Materia: Procesamiento Digital de Imagenes
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 14 de octubre 2013
% 
% Tarea No:5
% 
% Titulo: Transformaciones de intesidad
% 
% ------------------------------------------------------------------------

function Salida=imgraytrans(img,Trans,valores)% la función se llama imgraytrans


 if length(valores)==1 || isempty(valores)==0

 v=str2num(valores{1});                          %se obtienen los valores de la transformación
 v=double(v);
 
        if strcmp(Trans,'lin')==1 && length(v)==2  %lineal
           Salida=v(1).*img+v(2);
            Salida= uint8(Salida);
        elseif strcmp(Trans,'neg')==1 && isempty(valores)==0 %negativo
           Salida=255-img;
            Salida= uint8(Salida);
        elseif strcmp(Trans,'log')==1 && length(v)==1 
             rmax=max(max(img));                        %se obtiene rmax
             c=255/log(1+rmax);                          %constante c
             Salida=c.*log(1+(exp(v)-1).*img); 
             Salida= mat2gray(Salida);
         elseif strcmp(Trans,'gamma')==1 && length(v)==2     %Gamma
             Salida=1.*img.^v(2);
             Salida= mat2gray(Salida);
         elseif strcmp(Trans,'norm')==1 && isempty(valores)==0  %Normalizacion
             fmax=max(max(img));                          %fmax
             fmin=min(min(img));                          %fmin
             Salida=255.*((img-fmin)./(fmax-fmin));
             Salida= mat2gray(Salida);
        else
            disp('Error opcion incorrecta revisar los datos de entrada');
            Salida=1;
        end
        
 else
   disp('Error opcion incorrecta revisar los datos de entrada');
   Salida=1;
   
 end
        
