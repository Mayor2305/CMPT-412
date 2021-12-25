function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
X1 = x1 - centroid1;
X2 = x2 - centroid2;


%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
X1_dist = sqrt((X1(:, 1).^2) + (X1(:, 2).^2));
X2_dist = sqrt((X2(:, 1).^2) + (X2(:, 2).^2));

mean_X1 = mean(X1_dist);
mean_X2 = mean(X2_dist);

X1 = (X1 * sqrt(2)) / mean_X1;
X2 = (X2 * sqrt(2)) / mean_X2;

%% similarity transform 1
T1 = [  sqrt(2) / mean_X1, 0, -1.0 * (sqrt(2) / mean_X1) * centroid1(:, 1); 
        0, sqrt(2) / mean_X1, -1.0 * (sqrt(2) / mean_X1) * centroid1(:, 2);
        0, 0, 1];

%% similarity transform 2
T2 = [  sqrt(2) / mean_X2, 0, -1.0 * (sqrt(2) / mean_X2) * centroid2(:, 1); 
        0, sqrt(2) / mean_X2, -1.0 * (sqrt(2) / mean_X2) * centroid2(:, 2);
        0, 0, 1];

%% Compute Homography
H2to1 = computeH(X1, X2);

%% Denormalization
H2to1 = inv(T2) * H2to1 * T1;
