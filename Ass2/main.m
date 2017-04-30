function main(im_path1, im_path2)
%%%
% im_pat1 : path to first images, default 'House/frame00000001.png'
% im_pat2 : path to second images, default 'House/frame00000002.png'
%%%
% Read two images, single is needed for vlfeat
im1 = im2single( imread( 'House/frame00000001.png' ) );
im2 = im2single( imread( 'House/frame00000002.png' ) );

% get sift features
[fa, da] = vl_sift(im1);
[fb, db] = vl_sift(im2);

% match sift features
[matches, scores] = vl_ubcmatch(da, db);


P = 20
index = randsample(1:length(matches), P);
selection = matches(:,index);


xysample1 = fa(1:2, selection(1,:))'
xysample2 = fb(1:2, selection(2,:))'

x1 = xysample1(:,1);
y1 = xysample1(:,2);
x2 = xysample2(:,1);
y2 = xysample2(:,2);

A = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1.*y2, y1, x2, y2, ones(P,1)];  

[U, D, V] = svd(A);
F = reshape(V(:,end), [3,3])
[Uf, Df, Vf] = svd(F)
Df(3,3) = 0
F = Uf*Df*Vf'

%[transformation, final_sample, ~] = ransac(fa, fb, matches, 8  , 50);
%[frames1, frames2, matches] = siftmatches(im1, im2)
end