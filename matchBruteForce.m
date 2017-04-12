function [match, mindist,new_q] = matchBruteForce(p, q)
    m = size(p,2);
    n = size(q,2);    
    match = zeros(1,m);
    mindist = zeros(1,m);
    for ki=1:m
        d=zeros(1,n);
        for ti=1:3
            % q(ti,:) is the whole row of x,y or z, p(ti,ki) is only one
            % points x,y or z. 
            d=d+(q(ti,:)-p(ti,ki)).^2;
        end
        [mindist(ki),match(ki)]=min(d);
    end
    
    mindist = sqrt(mindist);
    
    new_q = zeros(size(p,1), size(p,2));
    
    for idx=1:m
        new_q(:,idx) = q(:,match(idx));
    end 
end % matchBruteForce