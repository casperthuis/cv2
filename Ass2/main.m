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


%[frames1, frames2, matches] = siftmatches(im1, im2)
end