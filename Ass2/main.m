function main(im_path1, im_path2)
%%%
% im_pat1 : path to first images, default 'House/frame00000001.png'
% im_pat2 : path to second images, default 'House/frame00000002.png'
%%%
% Read two images, single is needed for vlfeat
im1 =  imread( 'House/frame00000001.png' );
im2 =  imread( 'House/frame00000002.png' );

% Find sift matches
[matches, f1, f2, ~, ~] = find_matches( im1, im2);

%ransac
F = ransac_new(matches, f1, f2, 10)



end