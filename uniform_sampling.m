function [ match, mindist, new_q, new_p ] = uniform_sampling( p, q, percentage )
%UNIFORM_SAPLING Summary of this function goes here
%   Detailed explanation goes here
    m = size(p,2);
    n = size(q,2);
    k = (n*percentage);
    step = n / k;
    match = zeros(1,k);
    mindist = zeros(1,k);
    new_p = zeros(size(p,1), k);
    new_q = zeros(size(q,1), k);
    
    j = 1;
    for i=1:step:n
        d = sum((q(:,:) - p(:,i)).^2);
        [mindist(j),match(j)] = min(d);
        new_p(:, j) = p(:,i);
        new_q(:,j) = q(:,match(j));
        j = j + 1;
    end
        
    mindist = sqrt(mindist);
    
end

