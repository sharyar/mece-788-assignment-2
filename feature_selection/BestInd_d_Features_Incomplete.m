function [Index, Error] = BestInd_d_Features_Incomplete(d, Objective, Data)
% This Function Performs Best Individual d Feature Selection
% Complete This Function To Select Features Using Individual d Feature Selection

% Outputs are Index and Error
% (1) Index is a 1 by Number of Features vector which contains 1s for selected
% d Features and 0s for Other Features

% (2) Error Contains the Weighted Train + Test Error Obtained By Using only
% One Feature. Error is a 1 by Number of Features vector.

% Objective is the Objective Function Handle Which You Can Call to
% Calculate Error for Each Feature. Objective Input is a Vector Similar to
% Index.


% Index = []; % You Should Find/Return Index Values
Error = []; % You Should Find/Return Error Values

% STEP 1:
% Extract Input Data
Input = Data.Input;

% Evaluate ANN Error Using One Feature at a Time
num_features = Data.NumFeatures;

for i = 1:num_features
    feature_to_test = zeros(num_features);
    feature_to_test(i) = 1;
    Error(i) = Objective(feature_to_test);
end

% STEP 2: Sort Obtained Errors
[~, sort_order] = sort(Error);


% STEP 3: 
% Select First d Features With Minimum Error
Index = zeros(num_features);
for iter = 1:d
    Index(sort_order(iter)) = 1;
end

% Create a Binary output Named "Index"

end




