function [best_F, T1, T2, best_inliers_p1, best_inliers_p2] = ransac(matches, f1, f2, N)
best_inliers_num = 0;

p1 = f1(1:2, matches(1,:));
p2 = f2(1:2, matches(2,:));

% TODO: check whether we need to normalise points before hand
% normalise points
[T1, norm_p1] = normalisation(p1);
[T2, norm_p2] = normalisation(p2);

for i=1:N
    % pick random points
    perm = randperm(size(matches,2),8);
    p1_set = norm_p1(perm,:);
    p2_set = norm_p2(perm,:);
    
    % normalise points
    %[T, norm_p1] = normalisation(p1);
    %[T, norm_p2] = normalisation(p2);
    
    % Calculate F
    A = get_A_matrix(p1_set, p2_set);
    F  = make_F_matrix(A);
    
    % Count inliers
    [num_inliers, inliers_p1, inliers_p2] = count_inliers(F, norm_p1, norm_p2, matches, 1);
    
    % Determine if better previous best
    if num_inliers > best_inliers_num
        best_inliers_num = num_inliers;
        best_F = F;
        best_inliers_p1 = inliers_p1;
        best_inliers_p2 = inliers_p2;
    end
end
end