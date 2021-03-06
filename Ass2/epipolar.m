function epipolar(im_path1, im_path2)
    %%%
    % im_pat1 : path to first images, default 'House/frame00000001.png'
    % im_pat2 : path to second images, default 'House/frame00000002.png'
    %%%
    % Read two images

    if nargin == 0
        im_path1 = 'House/frame00000001.png';
        im_path2 = 'House/frame00000002.png';
    elseif nargin ==  1
        error('give at least two input pars, not 1')
    end 

    im1 =  imread( im_path1 );
    im2 =  imread(  im_path2 );

    % Find sift matches
    [matches, f1, f2, ~, ~] = find_matches(im1, im2);

    %ransac
    [F, T1, T2, p1_norm, p2_norm, best_inliers] = ransac(matches, f1, f2, 100, 1);

    %plot epilor lines for 20
    plot_epipolar(F, im1, im2, p1_norm(1:20,:), p2_norm(1:20,:), T1, T2);
    %plot epilor lines for 50
    plot_epipolar(F, im1, im2, p1_norm(1:50,:), p2_norm(1:50,:), T1, T2)
    %plot epilor lines for 200
    plot_epipolar(F, im1, im2, p1_norm(1:200,:), p2_norm(1:200,:), T1, T2)

end