function [num_inliers, inliers_p1, inliers_p2,inliers] = inliers(F, p1, p2, threshold)

d = sampson_distance(F, p1, p2);
num_inliers = sum(d < threshold);

inliers_p1 = p1(:,d < threshold);
inliers_p2 = p2(:,d < threshold);
% this are the idxs of the original inliers
inliers  = d < threshold;
end