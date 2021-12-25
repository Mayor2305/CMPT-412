clear all;
load lenet.mat;
source = sprintf('../images/image1.JPG');
img = imread(source);

img = im2double(img);
img = rgb2gray(img);
T = graythresh(img);
BW = imbinarize(img, T);

L = bwlabeln(BW, 4);

S = regionprops(L, 'BoundingBox');

S = struct2cell(S);
input = zeros(28 * 28, size(S,2));
for i = 1 : size(S, 2)
    im = imcrop(img, S{1, 2});
    row_size = size(im, 1);
    column_size = size(im, 2);
    if row_size ~= column_size
        padding = (max(row_size, column_size) - min(row_size, column_size)) / 2;
        im = padarray(im, [floor(padding) floor(padding)], 0, 'both');
    end
    input(:, i) = imresize(im, [28 * 28, 1]).';
end
layers = get_lenet();
[output, P] = convnet_forward(params, layers, input);
P
