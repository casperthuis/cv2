function [tparams]=RANSAC(f1, f2, N)
% 
% **** NOTE *****
% we are using vlfeat-0.9.20 package
% 
% Input parameters:
% (1) f1: absolute file path to image 1
% (2) f1: absolute file path to image 2
% (3) N: number of iterations for RANSAC algorithm


% set max inlier count to zero and initialize RANSAC variables
max_count = 0;
tparams = zeros([6 1]);
P = 3;
threshold = 10;
% apply RANSAC, loop through the sampled matchpoints
for i=1:N
    % construct a permutation vector of the matching points
    p_matches = randperm(size(T, 2));
    % select N number of matches
    sel_matches = p_matches(1:P) ;
    [A,b]=construct_A( f1(1:2, T(1, sel_matches)), f2(1:2, T(2, sel_matches)));   
    % vector X contains m1, m2, m3, m4, t1, t2 parameters for the affine
    % transformation
    X = pinv(A) * b;
    % transformation matrix, need to be transposed otherwise we end up with
    % [m1 m3; m2 m4] but we need [m1 m2 t1; m3 m4 t2]
    M = cat(1, transpose(reshape(X, [3 2])), [0 0 1]);
    [I2_MP]=transform_matchpoints(M, T, f1);
    [inliers]=get_inliers(f2, T, I2_MP, threshold);
    % if these parameters capture more inliers then save them
    if size(inliers, 2) >= max_count
        tparams = M;
        % contains the inlier set of T
        best_inliers = inliers;
    end
end


sprintf('Total # of matches %d. Maximum # of inliers: %d', size(T, 2), size(best_inliers,2))


    function [A,b]=construct_A(p1, p2)
        % function constructs the A matrix and the vector b based on the
        % sampled points
        
        % construct least square "ingredients", matrix A and vector b
        % b is the transformed feature point in image 2 (x,y) coordinates
        b = p2(:);
        % construct the first two parts of the A matrix (the third is 2D
        % identity matrix)
        u1 = [ p1(:,1)' 1; 0 0 0 ];
        u1 = cat(2, u1, flipud(u1));
        u2 = [ p1(:,2)' 1; 0 0 0 ];
        u2 = cat(2, u2, flipud(u2));
        u3 = [ p1(:,3)' 1; 0 0 0 ];
        u3 = cat(2, u3, flipud(u3));
        % concatenate three parts along the column dimension
        A = cat(1, u1, u2, u3);
    end % construct_A

    function [I2_MP]=transform_matchpoints(M, T, f1)
        % performs an affine transformation on all match points from image
        % 1 to image 2.
        % M: transformation matrix
        % T: total set of match points
        % f1: sift feature points in image 1
        % 
        % returns the "new" coordinates of the match points in image 2 (2 x
        % K) matrix (where K is number of match points)
        
        % T(1,:) contains all indexes of the match points in image 1
        % I1_MP contains all match point coordinates of image 1 (2 x K)
        % matrix
        I1_MP = f1(1:2, T(1,:));
        % transform mathing points to homogeneous coordinates
        I1_MP = cat(1, I1_MP, ones(1, size(I1_MP,2)));
        I2_MP = M * I1_MP;
        % omit the third row, to get non-homogeneous coordinates
        I2_MP = I2_MP(1:2, :);
        
    end % transform_matchpoints

    function [inliers]=get_inliers(f2, T, I2_MP, threshold)
        % computes the Euclidian distance between "approximated" match
        % points in image 2 and the match points that were calculated based
        % on the siftmatch function
        % I2_MP: contains a 2 x K (where K is total # of match points)
        % matrix with the coordinates of the match points.
        %
        % returns the indexes of the inliers. indexes come from matches T
        % that holds f1 and f2 indexes.
        
        % get center points of "ideal" match points found by siftmatch
        centerp_i2 = f2(1:2, T(2,:));
        xy_distance = sqrt( (I2_MP(1,:) - centerp_i2(1,:)).^2 + (I2_MP(2,:) - centerp_i2(2,:)).^2 );
        inliers = T(:, xy_distance <= threshold );
        
    end % count_inliers
end % RANSAC