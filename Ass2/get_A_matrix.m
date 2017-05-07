function A = get_A_matrix(p1, p2)
% Select points
x1 = p1(1,:)';
y1 = p1(2,:)';
x2 = p2(1,:)';
y2 = p2(2,:)';

% Create A
A = [x1 .* x2, x1 .* y2, x1, y1 .* x2, y1.*y2, y1, x2, y2, ones(size(p1,2),1)];  

end