%% real world example
clear all;
load lenet.mat;
for i = 1 : 5
    source = sprintf('../images/real_world/rw%d.png', i);
    img_real = imread(source);
    if ndims(img_real) == 3
        img_real = rgb2gray(im2double(img_real));
    end
    img_real = imresize(img_real, [28 28]);
    img_real = reshape(img_real.', [], 1);
    layers = get_lenet();
    layers {1}.batch_size = 1;
    [output, P] = convnet_forward(params, layers, img_real);
    [~, index] = max(P);
    disp(index - 1);
end
