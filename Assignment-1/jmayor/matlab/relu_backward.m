function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
data = max(0, input.data) == input.data; % first get max of 0 or input.data and then get a matrix with 1 or 0, 1 where max == input, 0 otherwise
input_od = output.diff .* data;
end
