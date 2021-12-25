
%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
confusion_matrix = zeros([10, 10]);
data = zeros([10, 10]);
max_value = 0;
max_index = 0;
for i = 1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [max_value, max_index] = max(P);
    
    correct_output = ytest(:, i : i + 99); %just like xtest above
    num_index = length(max_index);
    confusion_matrix = zeros([10, 10]);
    for index = 1 : num_index
        data(correct_output(index), max_index(index)) = data(correct_output(index), max_index(index)) + 1;
    end
    confusion_matrix = confusion_matrix + data;
end
disp(confusion_matrix)