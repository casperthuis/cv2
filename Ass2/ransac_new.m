function F = ransac_new(matches, f1, f2, N)
best_in_count = 0;

for i=1:N
    % pick random points
    index = randsample(1:length(matches), 8);
    selection = matches(:,index);
    p1 = f1(1:2, selection(1,:))';
    p2 = f2(1:2, selection(2,:))';
    
    
    % normalise points
    [T, norm_p1] = normalisation(p1);
    [T, norm_p2] = normalisation(p2);
    
    
    % Calculate F
    A = get_A_matrix(norm_p1, norm_p2);
    F  = make_F_Matrix(A)
    
    % Count inliers
    
    
    % Determine if better
    
    break
end

end