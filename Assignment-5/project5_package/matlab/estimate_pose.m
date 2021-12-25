function P = estimate_pose(x, X)
%COMPUTEH Computes the homography between two sets of points
    x1 = x';
    x2 = X';
    X2 = x1(:, 1);
    Y2 = x1(:, 2);
    X1 = x2(:, 1);
    Y1 = x2(:, 2);
    Z1 = x2(:, 3);
    
    for i = 1 : size(X1, 1)
        mat((2*i) - 1, :) = [ -X1(i), - Y1(i),-Z1(i), -1, 0, 0, 0, 0, X1(i) * X2(i), Y1(i) * X2(i), Z1(i) * X2(i), X2(i)];
        mat((2*i), :) = [ 0, 0, 0, 0, -X1(i), -Y1(i), -Z1(i), -1, X1(i) * Y2(i), Y1(i) * Y2(i), Z1(i) * Y2(i), Y2(i)];
    end
    
    [U, S, V] = svd(mat);

    P = reshape(V(:,end), 4, 3)';

end


