function [matches, f1, f2]=sift_matches(image1, image2)
    im1 = im2single( image1 );
    im2 = im2single( image2 );

    % get sift features
    [f1, da] = vl_sift(im1);
    [f2, db] = vl_sift(im2);

    % Match despribtors
    [matches, ~] = vl_ubcmatch(da, db);

end