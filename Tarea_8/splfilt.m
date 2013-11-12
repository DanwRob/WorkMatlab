function Salida=splfilt(img,opcion,t_k,a)% la función se llama imhistogram
[m,n]=size(img);
switch lower(opcion)
    case'gaussian'
        kernel=ones(t_k);
        t=floor(t_k/2);
        for y=-t:t
            for x=-t:t
            kernel(y+t+1,x+t+1)=exp(-(x^2+y^2)/(2*a^2));
            end
        end
        kernel=kernel/sum(sum(kernel));
        Salida=imfilter(img,kernel);
    case'amean'
        kernel=ones(t_k)/(t_k^2);
        Salida=imfilter(img,kernel);
    case'gmean'
       g=im2double(img);
       kernel=ones(t_k);
       Salida=exp(imfilter(log(g),kernel,'replicate')).^(1/t_k/t_k);
    case'hmean'
        g=im2double(img);
        kernel=ones(t_k);
        Salida=(t_k^2)./(imfilter(1./(g),kernel,'replicate'));     
    case'chmean'
        g=im2double(img);
        kernel=ones(t_k);
        Salida=imfilter(g.^(a+1),kernel,'replicate')./(imfilter(g.^(a),kernel,'replicate'));
        
    case'median'
        g=im2double(img);
        kernel=ones(t_k);
        Salida=ordfilt2(g,ceil((t_k^2)/2),kernel);
    case'hybmedian'
        g=im2double(img);
        k1=eye(t_k)|rot90(eye(t_k));
        k2=zeros(t_k);
        k2(ceil(t_k/2),:)=1;
        k2(:,ceil(t_k/2))=1;
        MH1=ordfilt2(g,fix(median(1:sum(sum(k1)))),k1);
        MH2=ordfilt2(g,fix(median(1:sum(sum(k2)))),k2);
        HB=zeros(m,n,3);
        HB(:,:,1)=MH1;
        HB(:,:,2)=MH2;
        HB(:,:,3)=g;
        Salida=zeros(m,n);
        for i=1:m
            for j=1:n
                  Salida(i,j)=median(HB(i,j,:));
            end
        end
    case'min'
        g=im2double(img);
        kernel=ones(t_k);
        Salida=ordfilt2(g,1,kernel);
    case'max'
        g=im2double(img);
        kernel=ones(t_k);
        Salida=ordfilt2(g,t_k^2,kernel,'symmetric');
    case'midpoint'
        g=im2double(img);
        kernel=ones(t_k);
        minimo=ordfilt2(g,1,kernel);
        maximo=ordfilt2(g,t_k^2,kernel);
        Salida=imlincomb(1/2,minimo,1/2,maximo);
    otherwise
        disp('Opcion incorrecta')
       
end




        