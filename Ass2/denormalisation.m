function p = denormalisation(T, p)

p = [p, ones(size(p,1),1)]';
p = transpose(T\p);
p = p(:,1:2);   
        
end

