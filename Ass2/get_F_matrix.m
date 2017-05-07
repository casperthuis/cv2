function  F  = get_F_matrix( p1, p2 )
%MAKEFUNDAMENTALMATRIX Summary of this function goes here
%   Detailed explanation goes here
A = get_A_matrix(p1, p2);
[~, ~, V] = svd(A);
F = reshape(V(:,end), [3,3]);
[Uf, Df, Vf] = svd(F);
Df(3,3) = 0;
F = Uf*Df*Vf';

end

