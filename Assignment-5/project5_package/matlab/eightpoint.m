function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

pts1_scaled = pts1 ./ M;
pts2_scaled = pts2 ./ M;

x1 = pts1_scaled(:, 1);
y1 = pts1_scaled(:, 2);

x2 = pts2_scaled(:, 1); 
y2 = pts2_scaled(:, 2);

one_ = ones(size(pts1, 1),1);

A = [x1 .* x2, x2 .* y1, x2, y2 .* x1, y1 .* y2, y2, x1, y1, one_];

[~, ~, V] = svd(A);

F = V(:, end);
F = reshape(F, 3, 3);

[U, S, V] = svd(F);

S(3, 3) = 0;
F = U*S*V';
F = refineF(F, pts1_scaled, pts2_scaled);

denorm = [1/M 0 0; 0 1/M 0; 0 0 1];
F = denorm' * F * denorm;

end