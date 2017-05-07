function norm_p = normalisation(T, points)
% Normalise points
phat = T* [points; ones(1, size(points,2))];
norm_p = phat(1:2, :);

end