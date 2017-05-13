function plot_epipolar(F, im1, im2, p1_norm, p2_norm, T1, T2)
    figure;
    p1_norm = [p1_norm, ones(size(p1_norm,1),1)]';
    p2_norm = [p2_norm, ones(size(p2_norm,1),1)]';

    p1 = transpose(T1\p1_norm);
    p2 = transpose(T2\p2_norm);
    F = T2' * F * T1;

    epi_lines1 = epipolarLine(F, p1(:,1:2));
    epi_lines2 = epipolarLine(F, p2(:,1:2));

    subplot(121);
    imshow(im1);
    title('Inliers and Epipolar Lines in First Image'); hold on;
    plot(p1(:,1),p1(:,2),'go');

    points = lineToBorderPoints(epi_lines1,size(im1));
    line(points(:,[1,3])',points(:,[2,4])');

    subplot(122);
    imshow(im2);
    title('Inliers and Epipolar Lines in Second Image'); hold on;
    plot(p2(:,1),p2(:,2),'go');

    points = lineToBorderPoints(epi_lines2,size(im2));
    line(points(:,[1,3])',points(:,[2,4])');

end
