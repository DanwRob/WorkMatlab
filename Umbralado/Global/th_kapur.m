function [ t ] = th_kapur( inputImage )
%th_kapur Metodo de umbralado global no parametricoclc
Y=imhist(inputImage);
pi=Y/sum(Y);
entropy=zeros(1,256);
n=length(Y);
Hn=0;
Ps=0;
Hs=0;

for i=1:n
    if pi(i)~=0
        Hn = Hn + pi(i)*log(pi(i));
    end
end
Hn=-Hn;

for s=1:n-1
        % obtengo Ps
        for i=1:s
            Ps = Ps + pi(i);
        end
        % obtengo Hs
        for i=1:s
            if pi(i)~=0
            Hs = Hs + pi(i)*log(pi(i));
            end
        end        
        Hs=-Hs;
        Ha=log(Ps)+(Hs/Ps);
        Hb=log(1-Ps) + ((Hn-Hs)/(1-Ps));
        entropy(s)=Ha+Hb;
        Ps=0;
        Hs=0;    
end

x=max(entropy);
t=find(entropy==x,1);
end

