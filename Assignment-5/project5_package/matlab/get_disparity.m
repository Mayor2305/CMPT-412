function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

dist = zeros(size(im1,1),size(im1,2));
disp = zeros(size(im1,1),size(im1,2), maxDisp+1);

for d = 0:maxDisp
    distance = 1: (size(im1,1) * (size(im1,2) - d));
    dist(distance) = (im1(distance + size(im1,1)*d) - im2(distance)).^2;
    window = ones(windowSize, windowSize);
    disp(:,:,d+1) = conv2(dist, window, 'same');
end

[~, i] = min(disp, [], 3);
dispM = i - 1;

