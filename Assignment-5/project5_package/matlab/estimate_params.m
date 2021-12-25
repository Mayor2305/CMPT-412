function [K, R, t] = estimate_params(P)
    
    [U, S, V] = svd(P);
    V = V(:,end);
    c = V(1:3,:)/V(4,:);
    
    A = P(1:3,1:3);
    
    P = [0 0 1; 0 1 0; 1 0 0];

    A = P * A;
    A = transpose(A);

    a1 =  A(:, 1);
    a2 =  A(:, 2);
    a3 =  A(:, 3);
    
    u1 = a1;
    e1 = u1/ norm(u1);
    u2 = a2 - (dot(a2,e1) * e1);
    e2 = u2/ norm(u2);
    u3 = a3 - (dot(a3,e1) * e1) - (dot(a3,e2) * e2);
    e3 = u3/ norm(u3);
    
    Q = [e1 e2 e3];
    R = [dot(a1,e1) dot(a2,e1) dot(a3,e1); 0 dot(a2,e2) dot(a3,e2); 0 0 dot(a3,e3)];

    
    K = P * transpose(R) * P;
    R = P * transpose(Q);
    t = -R * c;
    
end

