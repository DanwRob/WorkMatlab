function Salida=imnoises(I,opcion,a,b)% la función se llama imhistogram
I=im2double(I);
switch lower(opcion)
    case'uniform'
        U = rand(size(I));
        Salida=a+(b-a)*U;
        Salida=I+Salida;
    case'gaussian'
        N = randn(size(I));
        Salida=a+(b-a)*N;
        Salida=I+Salida;
    case'rayleigh'
        U = rand(size(I));
        Salida = a+sqrt(-b*log(1-U));
        Salida=I+Salida;
    case'lognormal'
        N = randn(size(I));
        Salida = exp(b*N + a);
        Salida=mat2gray(I+Salida);        
    case'exponential'
        U = rand(size(I));
        Salida = (-1/a)*(log(1-U));
        Salida=I+Salida;
    case'erlang'
        if(b~=round(b)||b<=0)
            disp('B tiene que ser un entero positivo, para el erlang');
            Salida=-1;
        else
            Salida=zeros(size(I));
            for j=1:b
                Salida = Salida+(-1/a)*log(1-rand(size(I)));
            end
            Salida=mat2gray(I+Salida);
        end
    case'salt&pepper'
        if(a+b)>1
            disp('La suma de a+b no debe ser mayor a 1, para el salt&pepper');
            Salida=-1;
        
        else
            U = rand(size(I));
            c=find(U<=a);
            I(c)=0;
            c=find(U>a&U<=(a+b));
            I(c)=1;
            Salida=I;
        end
    otherwise
        disp('Opcion incorrecta')
       
end




        