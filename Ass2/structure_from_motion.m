function [] = structure_from_motion(start_frame, end_frame)
    % get PVM and the D matrix (which is the PVM but the the x and y coords)
    [PVM, D] = point_view_matrix(start_frame, end_frame);
    
    
    % make a dense block, only use the columns where the intrest point is
    % present in every view
    idx_dense = find( sum([D == 0], 1) == 0);
    dense_block = D(:,idx_dense);
    
    % normalise dense block, for every row
    m = mean(dense_block,2);
    dense_block = dense_block - repmat(m, 1, size(dense_block,2));

    [U, W, V] = svd(dense_block);
    dense_block = U(:, 1:3) * W(1:3, 1:3) * V(:, 1:3)';


    M = U(:, 1:3) * W(1:3, 1:3)^(0.5);
    S = W(1:3, 1:3)^(0.5)* V(:, 1:3)';

    idx =  ones(1, size(S, 2));
    
    % filter out ourliers in the z axis
    treshold = 0.5;

    if (~all(S(3,:) < treshold)) 
        idx = idx(S(3,:) < treshold);
        S = S(:, S(3,:) < treshold);
    end

    if (~all(S(3,:) > -treshold)) 
        idx = idx(S(3,:) > -treshold);
        S = S(:, S(3,:) > -treshold);
    end
    
    % plot 3D reconstruction
    figure;
    scatter3(S(1,:),S(2,:),S(3,:), 400, idx, '.');
    colormap(summer);
    colorbar;
    
end

