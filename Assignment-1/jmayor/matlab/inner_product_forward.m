function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.

m = size(param.w, 1);

output.height = m;
output.width = input.width;
output.channel = input.channel;
output.batch_size = k;

for b = 1 : k
    output.data(:, b) = (param.w') * (input.data(:, b)) + (param.b');
end 
end
