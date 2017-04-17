function [ match, mindist, new_q, new_p] = random_sampling( p, q, percentage)
%RANDOM_SAMPLING Summary of this function goes here
%   Detailed explanation goes here
    m = size(p,2);
    n = size(q,2);
    k = round(n*percentage);
    match = zeros(1,k);
    mindist = zeros(1,k);
    r = randi([1 m],1,k);
    new_p = zeros(size(p,1), k);
    for i=1:k

        d = sum((q(:,:) - p(:,r(i))).^2);
        new_p(:, i) = p(:,r(i));
        [mindist(i),match(i)] = min(d);
        
    end
        
    mindist = sqrt(mindist);
    new_q = zeros(size(q,1), k);
    
    for idx=1:k
        new_q(:,idx) = q(:,match(idx));
    end 
    
    
end

