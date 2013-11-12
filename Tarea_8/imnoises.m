function Salida=imnoises(I,opcion,a,b)% la función se llama imhistogram

switch lower(opcion)
    case'uniform'
        U = rand(size(I));      %se crean numeros aleatorios uniforme
        Salida=a+(b-a)*U;       %se aplica la formula para el ruido uniform
        Salida=I+Salida;        %se suma el ruido a la imagen original
    case'gaussian'
        N = randn(size(I));     %se crean numeros aleatorios normales media 0 varianza 1
        Salida=a+(b-a)*N;       %se aplica la formula para el ruido gaussiano
        Salida=I+Salida;        %se suma el ruido a la imagen original
    case'rayleigh'
        U = rand(size(I));              %se crean numeros aleatorios uniforme
        Salida = a+sqrt(-b*log(1-U));   %se aplica la formula para el ruido rayleigh
        Salida=I+Salida;                %se suma el ruido a la imagen original
    case'lognormal'
        N = randn(size(I));             %se crean numeros aleatorios normales media 0 varianza 1
        Salida = exp(b*N + a);          %se aplica la formula para el ruido lognormal
        Salida=I+mat2gray(Salida);      %se suma el ruido a la imagen original 
    case'exponential'
        U = rand(size(I));              %se crean numeros aleatorios uniforme
        Salida = (-1/a)*(log(1-U));
        Salida=I+Salida;                %se suma el ruido a la imagen original
    case'erlang'
        if(b~=round(b)||b<=0)           %B tiene que ser un numero entero positivo
            disp('B tiene que ser un entero positivo, para el erlang');
            Salida=-1;
        else
            Salida=zeros(size(I));
            for j=1:b
                Salida = Salida+(-1/a)*log(1-rand(size(I)));     %Sumatoria de numeros aleatorios exponeciales de 1 hasta B
            end
            Salida=I+mat2gray(Salida);                          %se suma el ruido a la imagen original
        end
    case'salt&pepper'
        if(a+b)>1                   %la suma de a+b no debe ser mayor a 1
            disp('La suma de a+b no debe ser mayor a 1, para el salt&pepper');
            Salida=-1;
        
        else
            U = rand(size(I));      %se crean numeros aleatorios uniforme
            c=find(U<=a);           %se obtienen los numeros menores de <a> para volverlos pepper 
            I(c)=0;
            c=find(U>a&U<=a+b);      %se obtienen los numeros mayores de <a> pero menores que <a+b> para volverlos salt
            I(c)=1;
            Salida=I;               %se retorna la imagen con ruido
        end
    otherwise
        disp('Opcion incorrecta')
       
end




        