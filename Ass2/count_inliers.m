function [num_inliers, inliers] = count_inliers(F, p1, p2, threshold)
d = sampson_distance(F, p1, p2);
num_inliers = sum([d < threshold]);

inliers = p1([d < threshold],:);
%inliers_p2 = p2([d < threshold],:);
end