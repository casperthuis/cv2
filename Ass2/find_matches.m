function [matches, frames1, frames2, descriptors1, descriptors2 ] = findMatches( im1, im2)
    % get sift features
    [frames1, descriptors1] = vl_sift(im2single(im1));
    [frames2, descriptors2] = vl_sift(im2single(im2));
    
    % filter out background points 
    %[frames1, descriptors1] = vl_sift(im2single(im1), 'PeakThresh',0.02);
    %[frames2, descriptors2] = vl_sift(im2single(im2), 'PeakThresh',0.02);

    % match sift features
    % Threshold background
    [matches, ~] = vl_ubcmatch(descriptors1, descriptors2);

end

