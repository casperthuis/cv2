function [T, norm_p] = normalisation(points)
% Calculate mean
x = points(:,1);
y = points(:,2);
mean_x = mean(x);
mean_y = mean(y);
% calculate d
d = mean(sqrt((x - mean_x).^2 + (y - mean_y).^2));

% Calculate T
T = [sqrt(2)/d, 0, -mean_x*sqrt(2)/d; 0 ,sqrt(2)/d, -mean_y*sqrt(2)/d;0 , 0, 1];

% Normalise points

phat = T* [points; ones(1, size(points,2))];
norm_p = transpose(phat(1:2, :));

end