function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
    X1 = x1(:, 1);
    Y1 = x1(:, 2);
    X2 = x2(:, 1);
    Y2 = x2(:, 2);
    
    for i = 1 : size(X1, 1)
      
        mat((2*i) - 1, :) = [ -X1(i), - Y1(i), -1, 0, 0, 0, X1(i) * X2(i), Y1(i) * X2(i), X2(i)];
        mat((2*i), :) = [ 0, 0, 0, -X1(i), -Y1(i), -1, X1(i) * Y2(i), Y1(i) * Y2(i), Y2(i)];
    end
    
[U, S, V] = svd(mat);


H2to1 = reshape(V(:,end),3,3)';

end

