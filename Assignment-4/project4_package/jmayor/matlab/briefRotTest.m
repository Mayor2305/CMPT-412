% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
image = imread('../data/cv_cover.jpg');

if size(image, 3) == 3
    image = rgb2gray (image);
end
%% Compute the features and descriptors
corners = detectSURFFeatures(image);
% corners = detectFASTFeatures(image);
% [desc, locs] = computeBrief(image, corners.Location);
[desc, locs] = extractFeatures(image, corners,'Method', 'SURF');
hist = [];
for i = 0:36
    %% Rotate image
    image_rot = imrotate(image, i * 10);
    
    %% Compute features and descriptors
    corners2 = detectSURFFeatures(image_rot);
%     corners2 = detectFASTFeatures(image_rot);
% 	[desc2, locs2] = computeBrief(image_rot, corners2.Location);
  [desc2, locs2] = extractFeatures(image_rot, corners2,'Method', 'SURF');
    %% Match features
    threshold = 10.0;
    indexPairs = matchFeatures(desc, desc2, 'MatchThreshold', threshold, 'MaxRatio', 0.7);

    locs1 = locs(indexPairs(:,1),:);
    locs2 = locs2(indexPairs(:,2),:);
    
    showMatchedFeatures(image, image_rot, locs1, locs2, 'montage');

    %% Update histogram
    hist(i+1) = size(indexPairs, 1);
end

%% Display histogram
% bar(hist)
% xlabel('Rotation') 
% ylabel('Matches') 
% title('SURF with Fast')
