function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
    if size(I1, 3)==3
        I1 = rgb2gray(I1);
    end
    if size(I2, 3) == 3
        I2 = rgb2gray (I2);
    end

%% Detect features in both images
corners1 = detectFASTFeatures(I1);
corners2 = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations
[desc1, locs1] = computeBrief(I1, corners1.Location);
[desc2, locs2] = computeBrief(I2, corners2.Location);

%% Match features using the descriptors
threshold = 10.0;
indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', threshold,'MaxRatio', 0.67);

locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);

showMatchedFeatures(I1, I2, locs1, locs2, 'montage')

end

