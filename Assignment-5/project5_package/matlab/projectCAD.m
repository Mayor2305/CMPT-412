which -all hold
close all
clear

load('../data/PnP.mat', 'image', 'cad', 'x', 'X');

P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);

figure
imshow(image);

hold on
p = P * [X; ones(1, size(X, 2))];
p = p ./ p(3,:);
plot(p(1,:), p(2,:), 'r+', 'LineWidth', 2);
hold off

figure
trimesh(cad.faces, cad.vertices(:,1), cad.vertices(:,2), cad.vertices(:,3), 'EdgeColor', 'red');

figure
rotate = [R, t; [0,0,0,1]] * [cad.vertices.'; ones(1, size(cad.vertices, 1))];
trimesh(cad.faces, rotate(1, :), rotate(2, :), rotate(3, :), 'EdgeColor', 'red');

figure
c = P * [cad.vertices.'; ones(1, size(cad.vertices, 1))];
ca = c ./ c(3,:);

hold on
imshow(image)
patch('Faces', cad.faces(:,1:2), 'Vertices', [ca(1,:).', ca(2,:).'])
hold off
