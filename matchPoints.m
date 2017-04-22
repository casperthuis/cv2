function [match, mindist,new_q] = matchPoints(p, q, matching_type)
% -------------------------------------------------------------------------
%   Description:
%       Function that returns matching points in de target point cloud.
%       Brute force (match all points with all points) or using a  KNN
%       search
%
%   Input:
%       - p : source cloud
%       - q : target cloud 
%       - matching_type: kd_tree or brute_force
%
%   Output:
%       - match: matching idxs
%       - mindist: distance between source and matching target point
%       - new_q: q with the matching points
%
% -------------------------------------------------------------------------
    m = size(p,2);
    n = size(q,2);    
    match = zeros(1,m);
    mindist = zeros(1,m);
    new_q = zeros(size(p,1), size(p,2));
    if strcmp(matching_type, 'brute_force')
        for ki=1:m
            d = sum((q - p(:,ki)).^2);
            
            [mindist(ki),match(ki)]=min(d);
            new_q(:,ki) = q(:,match(ki));
        end
        mindist = sqrt(mindist);
    elseif strcmp(matching_type, 'kd_tree')
        Mdl = KDTreeSearcher(q.');
        match = knnsearch(Mdl,p.','K',1);
        for ki=1:m
            new_q(:,ki) = q(:,match(ki));
        end
    else 
        error('use a valid matching type: brute_force or kd_tree')
    end
end % matchBruteForce