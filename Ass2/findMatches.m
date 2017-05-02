function [matches, frames1, frames2, descriptors1, descriptors2 ] = findMatches( im1, im2)
    % get sift features
    [frames1, descriptors1] = vl_sift(im1);
    [frames2, descriptors2] = vl_sift(im2);

    % match sift features
    [matches, scores] = vl_ubcmatch(descriptors1, descriptors2);

end

