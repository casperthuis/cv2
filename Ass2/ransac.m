function [best_F, best_T1, best_T2, best_inliers_p1, best_inliers_p2, best_inliers_idx] = ransac(matches, f1, f2, N, threshold)
    best_inliers_num = 0;

    p1 = f1(1:2, matches(1,:));
    p2 = f2(1:2, matches(2,:));


    for i=1:N
        % pick 8 random points
        perm = randperm(size(matches,2),8);
        p1_set = p1(:, perm);
        p2_set = p2(:, perm);



        % normalise points
        T1 = get_T_matrix(p1_set);
        T2 = get_T_matrix(p2_set);
        norm_p1_set = normalisation(T1, p1_set);
        norm_p2_set = normalisation(T2, p2_set);
        norm_p1 = normalisation(T1, p1);
        norm_p2 = normalisation(T2, p2);

        % Calculate F
        F = get_F_matrix(norm_p1_set, norm_p2_set);

        % Count inliers
        [num_inliers, inliers_p1, inliers_p2, inliers_idx] = count_inliers(F, norm_p1, norm_p2, threshold);

        % Determine if better than previous best
        if num_inliers > best_inliers_num
            best_inliers_num = num_inliers;
            best_F = F;
            best_inliers_p1 = inliers_p1';
            best_inliers_p2 = inliers_p2';
            best_T1 = T1;
            best_T2 = T2;
            best_inliers_idx = inliers_idx;
        end
    end
end