function Hp=freqfilt(I,tipo,opcion,D0,n)
[Y,X]=size(I);                      %se obtiene el tamaño de la imagen
[M,N]=meshgrid(0:Y-1,0:X-1);       
F=I.*((-1).^(M+N));                 %se obtiene el tamaño de la imagen
F=fft2(F);                          %se aplica la transformada de fourier

switch lower(tipo)                  %Si es Low Pass o High Pass
    case 'lp'
      switch lower(opcion)                              %Opcion de Filtro
          case 'ideal'
                H=zeros(Y,X);                   
                [V,U]=meshgrid(0:Y-1,0:X-1);            
                D=sqrt((V-(Y/2)).^2+(U-(X/2)).^2);      %se calcula la distancia con respecto al origen
                Ha=find(D<=D0);                         %se obtienen la frecuencia de corte con D0
                H(Ha)=1;                                
                Hp=H.*F;                                %Se multiplica el filtro por la transformada de Fourier
                Hp=abs(ifft2(Hp));                      % se aplica la inversa de la trasformada de fourier
          case 'butterworth'
                X2=X/2;
                Y2=Y/2;
                [V,U]=meshgrid(-Y2:Y2-1,-X2:X2-1);
                D=sqrt(U.^2+V.^2);                      %se calcula la frecuencia de corte de distancia
                H=1./(1+(D/D0).^(2*n));                 %Se obtiene el filtro 
                Hp=H.*F;                                 %Se multiplica el filtro por la transformada de Fourier
                Hp=abs(ifft2(Hp));                      % se aplica la inversa de la trasformada de fourier 
          case 'gaussian'
                X2=X/2;
                Y2=Y/2;
                [V,U]=meshgrid(-Y2:Y2-1,-X2:X2-1);
                D=-(U.^2+V.^2);                          %se calcula la frecuencia de corte de distancia
                H=exp(D/(2*(D0^2)));                     %Se obtiene el filtro    
                Hp=H.*F;                                %Se multiplica el filtro por la transformada de Fourier
                Hp=abs(ifft2(Hp));                      % se aplica la inversa de la trasformada de fourier 
          otherwise 
        disp('Opcion incorrecta')
      end        
    case 'hp'
        switch lower(opcion)
          case 'ideal'
                H=ones(Y,X);               
                [V,U]=meshgrid(0:Y-1,0:X-1);
                D=sqrt((V-(Y/2)).^2+(U-(X/2)).^2);      %se calcula la distancia con respecto al origen
                Ha=find(D<=D0);                         %se obtienen la frecuencia de corte con D0
                H(Ha)=0;                                
                Hp=H.*F;                                %Se multiplica el filtro por la transformada de Fourier
                Hp=abs(ifft2(Hp));                      % se aplica la inversa de la trasformada de fourier
          case 'butterworth'        
                X2=X/2;
                Y2=Y/2;
                [V,U]=meshgrid(-Y2:Y2-1,-X2:X2-1);
                D=sqrt(U.^2+V.^2);                    %se calcula la frecuencia de corte de distancia  
                H=1-(1./(1+(D/D0).^(2*n)));               %Se obtiene el filtro   
                Hp=H.*F;                              %Se multiplica el filtro por la transformada de Fourier  
                Hp=abs(ifft2(Hp));                    % se aplica la inversa de la trasformada de fourier       
          case 'gaussian'
                X2=X/2;
                Y2=Y/2;
                [V,U]=meshgrid(-Y2:Y2-1,-X2:X2-1);
                D=-(U.^2+V.^2);                     %se calcula la frecuencia de corte de distancia    
                H=1-(exp(D/(2*(D0^2))));            %Se obtiene el filtro        
                Hp=H.*F;                            %Se multiplica el filtro por la transformada de Fourier    
                Hp=abs(ifft2(Hp));                  % se aplica la inversa de la trasformada de fourier     
                            
          otherwise 
            disp('Opcion incorrecta')
        end 
        
    otherwise 
        disp('Opcion incorrecta')
end




