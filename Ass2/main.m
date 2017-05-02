function main(im_path1, im_path2)
%%%
% im_pat1 : path to first images, default 'House/frame00000001.png'
% im_pat2 : path to second images, default 'House/frame00000002.png'
%%%
% Read two images, single is needed for vlfeat
im1 =  imread( 'House/frame00000001.png' );
im2 =  imread( 'House/frame00000002.png' );

[matches, f1, f2, da, db ] = findMatches( im1, im2)


N = 20;


index = randsample(1:length(matches), N);
selection = matches(:,index);


p1 = fa(1:2, selection(1,:))';
p2 = fb(1:2, selection(2,:))';

[T, norm_p1] = normalisation(p1);
[T, norm_p2] = normalisation(p2);

x1 = p1(:,1);
y1 = p1(:,2);
x2 = p2(:,1);
y2 = p2(:,2);

A = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1.*y2, y1, x2, y2, ones(N,1)];  

[U, D, V] = svd(A);
F = reshape(V(:,end), [3,3]);
[Uf, Df, Vf] = svd(F);
Df(3,3) = 0;
F = Uf*Df*Vf';



%[transformation, final_sample, ~] = ransac(fa, fb, matches, 8  , 50);
%[frames1, frames2, matches] = siftmatches(im1, im2)
end