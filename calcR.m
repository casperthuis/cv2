function [ R ] = calcR(P,Q,P_mean,Q_mean)
% -------------------------------------------------------------------------
%   Description:
%       Function that returns the rotation matrix between two Point cluds
%
%   Input:
%       - P : source cloud
%       - Q : target cloud
%       - P_mean : centroid of the source cloud
%       - Q_mean : centroid of the target cloud 
%
%   Output:
%       - R: rotation Matrix transposed
%
% -------------------------------------------------------------------------
    norm_source = P - P_mean;
    norm_target = Q - Q_mean;

    S = norm_source * norm_target.';
    [U,~,V] = svd(S);
    
    I = eye(size(U,1));
    I(size(I,1),size(I,2)) = det(V * U.');
    R = V * I * U.';
    R = R';
end

