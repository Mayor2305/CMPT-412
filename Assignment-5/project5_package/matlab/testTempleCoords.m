im1 = imread("../data/im1.png");
im2 = imread("../data/im2.png");
point_correspondances = load('../data/someCorresp.mat');

pts1 = point_correspondances.pts1;
pts2 = point_correspondances.pts2;
M = point_correspondances.M;

F = eightpoint(pts1, pts2, M);

templeCoords = load('../data/templeCoords.mat');
tc_pts = templeCoords.pts1;
tc_pts2 = epipolarCorrespondence(im1, im2, F, tc_pts);

intrinsics = load('../data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;
E = essentialMatrix(F, K1, K2);

P1 = K1* [eye(3) zeros(3, 1)];
p2 = camera2(E);
 
max_points = -inf;
 

for i = 1:4
    P2 = p2(:,:,i);
    pts3d = triangulate(P1, tc_pts, P2, tc_pts2);
    sum = 0;
    for j = 1 : size(pts3d(:,3), 1)
        if pts3d(j,3) > 0
            sum = sum + 1;
        end
    end
    if max_points < sum
        max_points = sum;
        plot_y = pts3d;
        index = i;
    end
end
plot3(plot_y(:, 1), plot_y(:, 3), -plot_y(:, 2), '.'); axis equal

R1 =  eye(3);
t1 = [0;0;0];
R2 = p2(:, 1:3, index);
R2(:,2) = - R2(:, 2);
R2(:,3) = - R2(:, 3);
t2 = p2(:, 4, index);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');