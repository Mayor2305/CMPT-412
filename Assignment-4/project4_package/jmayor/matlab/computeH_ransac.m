function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
num_locs = size(locs1, 1);
count_actual = 0;
for i = 1: 500 %100
    random_index = randperm(num_locs, 4);
    new_loc1 = locs1(random_index, :);
    new_loc2 = locs2(random_index, :);
    
    h1 = [locs1(:, 1)'; locs1(:, 2)'; ones(size(locs1, 1), 1)'];
    h2 = [locs2(:, 1)'; locs2(:, 2)'; ones(size(locs2, 1), 1)'];

    H = computeH_norm(new_loc1, new_loc2);
    
    h1 = H * h1;
    h1 = h1 ./ h1(3, :);
    
    sub = h1 - h2;
    
    distance = sqrt((sub(2, :).^2) + (sub(1, :).^2));
    arr(i) = mean(distance);
    inliers_temp = zeros (1, num_locs);
    count_found = 0;
    
    for j = 1 : num_locs
        if distance (j) < 10
            inliers_temp(j) = 1;
            count_found = count_found + 1;
        end
    end
    
    if count_actual < count_found
        inliers = inliers_temp;
        count_actual = count_found;
    end
end
    bestH2to1 = computeH_norm(locs1(inliers == 1, :), locs2(inliers == 1, :));
end

