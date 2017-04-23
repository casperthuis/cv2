function [ R ] = calcR(P,Q,P_mean,Q_mean)
    norm_source = P - P_mean;
    norm_target = Q - Q_mean;

    S = norm_source * norm_target.';
    [U,~,V] = svd(S);
    
    I = eye(size(U,1));
    I(size(I,1),size(I,2)) = det(V * U.');
    R = V * I * U.';
    R = R';
end

