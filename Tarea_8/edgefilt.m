function Salida=edgefilt(img,opcion,A,B)% la función se llama imhistogram

switch lower(opcion)
    case'gradient'
        img=im2double(img);             %se convierte la imagen en double
        [Mi,Ni] = size(img);            
        ix = [1,1:Ni-1];                %recorre los indices de los pixeles
        iy = [1,1:Mi-1];
        Gx = img(:,ix) - img;           %calcula el gradiente
        Gy = img(iy,:) - img;
        Salida = abs(Gx)+abs(Gy);       %suma los dos gradiantes para obtener la imagen final
    case'prewitt'
        img = im2double(img);           %se convierte la imagen en double
        Gx=[1,0,-1;                     %mascara de convolucion
            1,0,-1;
            1,0,-1];
        Gy=Gx';
        x=imfilter(img,Gx,'replicate');      %se aplica el filtrado con la mascara de convolucion y la imagen
        y=imfilter(img,Gy,'replicate');       %se aplica el filtrado con la mascara de convolucion y la imagen
        Salida = abs(x)+abs(y);                %se obtiene la imagen final
    case'sobel'
        img = im2double(img);                   %se convierte la imagen en double
        Gx=[1,0,-1;2,0,-2;1,0,-1];              %mascara de convolucion
        Gy=Gx';
        x=imfilter(img,Gx,'replicate');          %se aplica el filtrado con la mascara de convolucion y la imagen
        y=imfilter(img,Gy,'replicate');         %se aplica el filtrado con la mascara de convolucion y la imagen
        Salida = abs(x)+abs(y);                 %se obtiene la imagen final
    case'kirsch'
        Salida=zeros(size(img));                
        error=0;
       
        img = im2double(img);        %se convierte la imagen en double
        N=[-3,-3,-3;                   %mascara de convolucion
            -3,0,-3;
            5,5,5];
        NE=[-3,-3,-3;                   %mascara de convolucion
            5,0,-3;
            5,5,-3];
        
        W=rot90(N);                             %rotacion para crear las demas mascaras de convulacion   
        NW=rot90(NE);               %rotacion para crear las demas mascaras de convulacion
       
        S=rot90(W);             %rotacion para crear las demas mascaras de convulacion
        SW=rot90(NW);               %rotacion para crear las demas mascaras de convulacion
        
        E=rot90(S);             %rotacion para crear las demas mascaras de convulacion
        SE=rot90(SW);               %rotacion para crear las demas mascaras de convulacion
        remain=A;
        for i=1:2
            [token, remain] = strtok(remain);       
            switch upper(token)                 %se analiza que mascaras se van a usar
                case 'N'
                    Kernel=N;
                case 'NE'
                    Kernel=NE;
                case 'W'
                    Kernel=W;
                case 'NW'
                    Kernel=NW;
                case 'S'
                    Kernel=S;
                case 'SW'
                    Kernel=SW;
                case 'E'
                    Kernel=E;
                case 'SE'
                    Kernel=SE;
                otherwise
                    error=1;
            end
            if error~=-1
             x=imfilter(img,Kernel,'replicate');        %se aplica el filtrado con la mascara de convolucion y la imagen
             Salida = Salida+abs(x); 
            end
        end
        
    case'robinson'
        remain=A;
         error=0;
         Salida=zeros(size(img));
       img = im2double(img);       %se convierte la imagen en double 
        N=[-1,-2,-1;            %mascara de convolucion
            0,0,0;
            1,2,1];
        NE=[0,-1,-2;        %mascara de convolucion
            1,0,-1;
            2,1,0];
        
        W=rot90(N);         %rotacion para crear las demas mascaras de convulacion   
        NW=rot90(NE);           %rotacion para crear las demas mascaras de convulacion
       
        S=rot90(W);         %rotacion para crear las demas mascaras de convulacion
        SW=rot90(NW);           %rotacion para crear las demas mascaras de convulacion
        
        E=rot90(S);         %rotacion para crear las demas mascaras de convulacion
        SE=rot90(SW);           %rotacion para crear las demas mascaras de convulacion
        
       for i=1:2
            [token, remain] = strtok(remain);
            switch upper(token) %se analiza que mascaras se van a usar
                case 'N'
                    Kernel=N;
                case 'NE'
                    Kernel=NE;
                case 'W'
                    Kernel=W;
                case 'NW'
                    Kernel=NW;
                case 'S'
                    Kernel=S;
                case 'SW'
                    Kernel=SW;
                case 'E'
                    Kernel=E;
                case 'SE'
                    Kernel=SE;
                otherwise
                    error=1;
            end
            if error~=-1
             x=imfilter(img,Kernel,'replicate');    %se aplica el filtrado con la mascara de convolucion y la imagen
             Salida = Salida+abs(x); 
            end
        end 
    case'newton'
         remain=A;
         error=0;
         Salida=zeros(size(img));
       img = im2double(img);            %se convierte la imagen en double    
        N=[1,2,1;                   %mascara de convolucion
           1,2,1;
          -2,-4,-2];
        NE=[1,1,2;                  %mascara de convolucion
            -2,2,1;
            -4,-2,1];
        
        W=rot90(N);             %rotacion para crear las demas mascaras de convulacion   
        NW=rot90(NE);           %rotacion para crear las demas mascaras de convulacion
       
        S=rot90(W);             %rotacion para crear las demas mascaras de convulacion
        SW=rot90(NW);           %rotacion para crear las demas mascaras de convulacion
        
        E=rot90(S);             %rotacion para crear las demas mascaras de convulacion
        SE=rot90(SW);           %rotacion para crear las demas mascaras de convulacion
       for i=1:2
            [token, remain] = strtok(remain);
            switch upper(token)
                case 'N'                    %se analiza que mascaras se van a usar
                    Kernel=N;
                case 'NE'
                    Kernel=NE;
                case 'W'
                    Kernel=W;
                case 'NW'
                    Kernel=NW;
                case 'S'
                    Kernel=S;
                case 'SW'
                    Kernel=SW;
                case 'E'
                    Kernel=E;
                case 'SE'
                    Kernel=SE;
                otherwise
                    error=1;
            end
            if error~=-1
             x=imfilter(img,Kernel,'replicate');    %se aplica el filtrado con la mascara de convolucion y la imagen
             Salida = Salida+abs(x); 
            end
        end  
    case'laplacian'
        img=im2double(img);         %imagen se convierte a Double
        vecino4N=[0,1,0;            %mascara de convolucion 4Negativo
          1,-4,1;
          0,1,0];
        vecino4P=[0,-1,0;           %mascara de convolucion 4Positivo
            -1,4,-1;
            0,-1,0];
         vecino8P=[-1,-1,-1;        %mascara de convolucion 8Positivo
          -1,8,-1;
          -1,-1,-1];
        vecino8N=[1,1,1;            %mascara de convolucion 8Negativo
            1,-8,1;
            1,1,1];
        switch(A)                   %analiza opcion escogida
            case 4
              Salida=imfilter(img,vecino4P,'replicate');            %se aplica el filtrado con la mascara de convolucion y la imagen
              Salida=abs(Salida); 
            case -4
               Salida=imfilter(img,vecino4N,'replicate');           %se aplica el filtrado con la mascara de convolucion y la imagen
               Salida=abs(Salida); 
            case 8
              Salida=imfilter(img,vecino8P,'replicate');            %se aplica el filtrado con la mascara de convolucion y la imagen    
                 Salida=abs(Salida); 
            
            case -8
             Salida=imfilter(img,vecino8N,'replicate');         %se aplica el filtrado con la mascara de convolucion y la imagen
             Salida=abs(Salida); 
        end
        
        
    case'log'
        img=im2double(img);                 %imagen se convierte a Double
        kernel=ones(A);
        t=floor(A/2);
        for y=-t:t
            for x=-t:t
            kernel(y+t+1,x+t+1)=((x^2+y^2-(2*B^2))/B^4)*(exp(-(x^2+y^2)/(2*B^2)));   %Se crea mascara de convolacion gaussiana    
            end
        end

         Salida=imfilter(img,kernel,'replicate');                   %se aplica el filtrado con la mascara de convolucion y la imagen
          
    case'dog'
        img=im2double(img);
         k1=ones(A);
         k2=ones(A);
            t=floor(A/2);
            for y=-t:t
                for x=-t:t
                k1(y+t+1,x+t+1)=(1/B(1))*exp(-(x^2+y^2)/(2*B(1)^2));            %Se crea mascara de convolacion gaussiana k1  
                k2(y+t+1,x+t+1)=(1/B(2))*exp(-(x^2+y^2)/(2*B(2)^2));            %Se crea mascara de convolacion gaussiana  k2 
                end
            end
         kernel=(1/sqrt(2*pi))*(k1-k2);                                         %Se obtiene la diferencia de k1 y k2 para obtener el kernel
            Salida=imfilter(img,kernel,'replicate');                            %se aplica el filtrado con la mascara de convolucion y la imagen
       
    otherwise
        disp('Opcion incorrecta')
       
end





