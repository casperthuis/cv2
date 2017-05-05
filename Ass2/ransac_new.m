function F = ransac_new(matches, f1, f2, N)
best_inliers_num = 0;

p1 = f1(1:2, matches(1,:));
p2 = f1(1:2, matches(2,:));
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
    [num_inliers, inliers] = count_inliers(F, norm_p1, norm_p2, 1);
    
    % Determine if better
    if num_inliers > best_inliers_num
        best_inliers_num = num_inliers
        best_F = F;
        best_inliers = inliers;
    end
    
end

end