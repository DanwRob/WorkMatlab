function Salida=edgefilt(img,opcion,A,B)% la función se llama imhistogram

switch lower(opcion)
    case'gradient'
         img=im2double(img);
      [Mi,Ni] = size(img);
        ix = [1,1:Ni-1];
        iy = [1,1:Mi-1];
        Gx = img(:,ix) - img;
        Gy = img(iy,:) - img;
        Salida = abs(Gx)+abs(Gy); 
    case'prewitt'
        img = im2double(img);
        Gx=[1,0,-1;1,0,-1;1,0,-1];
        Gy=Gx';
        x=imfilter(img,Gx,'replicate');      
        y=imfilter(img,Gy,'replicate');
        Salida = abs(x)+abs(y); 
    case'sobel'
        img = im2double(img);        
        Gx=[1,0,-1;2,0,-2;1,0,-1];
        Gy=Gx';
        x=imfilter(img,Gx,'replicate');      
        y=imfilter(img,Gy,'replicate');
        Salida = abs(x)+abs(y); 
    case'kirsch'
        Salida=zeros(size(img));
        error=0;
       
        img = im2double(img);        
        N=[-3,-3,-3;
            -3,0,-3;
            5,5,5];
        NE=[-3,-3,-3;
            5,0,-3;
            5,5,-3];
        
        W=rot90(N);
        NW=rot90(NE);
       
        S=rot90(W);
        SW=rot90(NW);
        
        E=rot90(S);
        SE=rot90(SW);
        remain=A;
        for i=1:2
            [token, remain] = strtok(remain);
            switch upper(token)
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
             x=imfilter(img,Kernel,'replicate');
             Salida = Salida+abs(x); 
            end
        end
        
    case'robinson'
        remain=A;
         error=0;
         Salida=zeros(size(img));
       img = im2double(img);        
        N=[-1,-2,-1;
            0,0,0;
            1,2,1];
        NE=[0,-1,-2;
            1,0,-1;
            2,1,0];
        
        W=rot90(N);
        NW=rot90(NE);
       
        S=rot90(W);
        SW=rot90(NW);
        
        E=rot90(S);
        SE=rot90(SW);
        
       for i=1:2
            [token, remain] = strtok(remain);
            switch upper(token)
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
             x=imfilter(img,Kernel,'replicate');
             Salida = Salida+abs(x); 
            end
        end 
    case'newton'
         remain=A;
         error=0;
         Salida=zeros(size(img));
       img = im2double(img);        
        N=[1,2,1;
           1,2,1;
          -2,-4,-2];
        NE=[1,1,2;
            -2,2,1;
            -4,-2,1];
        
        W=rot90(N);
        NW=rot90(NE);
       
        S=rot90(W);
        SW=rot90(NW);
        
        E=rot90(S);
        SE=rot90(SW);
       for i=1:2
            [token, remain] = strtok(remain);
            switch upper(token)
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
             x=imfilter(img,Kernel,'replicate');
             Salida = Salida+abs(x); 
            end
        end  
    case'laplacian'
        img=im2double(img);
        vecino4N=[0,1,0;
          1,-4,1;
          0,1,0];
        vecino4P=[0,-1,0;
            -1,4,-1;
            0,-1,0];
         vecino8P=[-1,-1,-1;
          -1,8,-1;
          -1,-1,-1];
        vecino8N=[1,1,1;
            1,-8,1;
            1,1,1];
        switch(A)
            case 4
              Salida=imfilter(img,vecino4P,'replicate');
              Salida=abs(Salida); 
            case -4
               Salida=imfilter(img,vecino4N,'replicate');
               Salida=abs(Salida); 
            case 8
              Salida=imfilter(img,vecino8P,'replicate');      
                 Salida=abs(Salida); 
            
            case -8
             Salida=imfilter(img,vecino8N,'replicate');
             Salida=abs(Salida); 
        end
        
        
    case'log'
        kernel=ones(A);
        t=floor(A/2);
        for y=-t:t
            for x=-t:t
            kernel(y+t+1,x+t+1)=((x^2+y^2-(2*B^2))/B^4)*(exp(-(x^2+y^2)/(2*B^2)));
            end
        end
         Salida=imfilter(img,kernel,'replicate');
           
    case'dog'
        
         k1=ones(A);
         k2=ones(A);
            t=floor(A/2);
            for y=-t:t
                for x=-t:t
                k1(y+t+1,x+t+1)=(1/B(1))*exp(-(x^2+y^2)/(2*B(1)^2));
                k2(y+t+1,x+t+1)=(1/B(2))*exp(-(x^2+y^2)/(2*B(2)^2));
                end
            end
        kernel=(1/sqrt(2*pi))*(k1-k2);
         Salida=imfilter(img,kernel,'replicate');
    otherwise
        disp('Opcion incorrecta')
       
end





