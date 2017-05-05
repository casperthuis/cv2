function [num_inliers, inliers_p1, inliers_p2] = count_inliers(F, p1, p2, matches, threshold)

d = sampson_distance(F, p1, p2);
num_inliers = sum(d < threshold);

inliers_p1 = p1(d < threshold,:);
inliers_p2 = p2(d < threshold,:);
end