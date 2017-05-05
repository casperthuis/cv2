function  F  = make_F_matrix( A )
%MAKEFUNDAMENTALMATRIX Summary of this function goes here
%   Detailed explanation goes here
[~, ~, V] = svd(A);
F = reshape(V(:,end), [3,3]);
[Uf, Df, Vf] = svd(F);
Df(3,3) = 0;
F = Uf*Df*Vf';

end

