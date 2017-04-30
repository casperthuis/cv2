function [T, norm_p] = normalisation(points)
x = points(:,1);
y = points(:,2);
mean_x = mean(x);
mean_y = mean(y);

sq_x = (x - mean_x).^2;
sq_y = (y - mean_y).^2;

d = mean(sqrt(sq_x + sq_x));

T = [sqrt(2)/d, 0, -mean_x*sqrt(2)/d; 0 ,sqrt(2)/d, -mean_y*sqrt(2)/d;0 , 0, 1]

proof = T* [ points, ones(length(x),1)]';

norm_p = proof(1:2, :);

end