function [ t ] = th_rosenfeld( inputImage )
%th_rosenfeld Metodo de umbralado Global no Parametrico
    Y=imhist(inputImage);
    Haux=Y;
    % 1. suavizado de cinco puntos
    for i=3:254
        Y(i)=(Haux(i-2) + Haux(i-1)+ Haux(i) + Haux(i+1) + Haux(i+2))/5;
    end
    
    % 2. envoltura convexa H
    index=(1:256)';
    H=sort(convhull(Y,index));
    HConvex=0;
    for i=1:length(H)-2
        linsp=linspace(Y(H(i)),Y(H(i+1)),(H(i+1)-H(i)));
        if(isempty(linsp))
            HConvex=horzcat(HConvex,[0]);
        else
        HConvex=horzcat(HConvex,linsp);    
        end
    end

    % 3. Diferencia envoltura convexa (HConvex) - histograma (Y)
    %    y encontrando los maximos locales (L)
    HConvex=(HConvex');
    Y=abs(HConvex - Y);
    L=zeros(1,255);
    for i=2:255    
            if (Y(i-1) < Y(i) && Y(i) > Y(i+1))
                L(i)=Y(i);
            end
    end

    Y=L;
    H=zeros(1,255);
    % 4. Calcular balance bj
    An=A(Haux,255);
    for i=1:255
        Aj=A(Haux,i);
        Ax=Aj*(An-Aj);
        H(i) = Y(i)*Ax;
    end
    m=max(H);
    t=find(H==m,1);
end

