%% (1) Initialization and Problem Creation
clc
clear

% BodyFat or BreastCancer
Dataset_Name = 'BodyFat';
% Load Dataset
Data = LoadData(Dataset_Name);
pl
%% (2) Sequential Forward/Backward Search
% Create Objectve Function
Objective = @(Input_tr, Output_tr, Input_test, Output_test) SequentialFeatureSelection(...
    Input_tr, Output_tr, Input_test, Output_test);

opts = statset('Display','iter');
[SFIndex_SFBS, history] = sequentialfs(Objective, Data.Input', Data.Output', ...
    'cv', 5 , 'options',opts);

%% (3) Laplacian Scores Method
% d --> Desired Number of Features 
d = 5; 

[Index_LS, LSs] = fsulaplacian(Data.Input','Distance', 'seuclidean');

% Plot Results
figure(1)
bar(LSs(Index_LS))
xlabel('Feature Rank')
ylabel('Feature Importance Score')  
SFIndex_LS = zeros(1,length(Index_LS));
SFIndex_LS(Index_LS(1:d)) = 1;

%% (4) Best Individual d Features (Complete This Section)
% Weight for Error in Training Data (from 0 to 1)
WeightTrain = 0.5;
% Number of Artificial Neural Network Evaluations
NumExecutions = 20;
% Create Objectve Function
Objective = @(Index) FeatureSelectionObjective(...
    Index, Data, WeightTrain, NumExecutions);

% d --> Desired Number of Features 
d = 5; 

[SFIndex_BIdF, Error] = BestInd_d_Features_Incomplete(d, Objective, Data);

%% (5) Principal Component Analysis
% d --> Desired Number of Features 
d = 5;

% Apply PCA
[~, score, ~, ~,explained, ~] = pca(Data.Input'); 
plot(1:Data.NumFeatures, cumsum(explained), '-x')
xticks(1:Data.NumFeatures), grid on
xlabel('Number of Features');
ylabel('% of Total Variance explained by each Componenent')

% Create Transformed Input
Data_PCA = Data;
Data_PCA.Input = score(:,1:d)';
Data_PCA.d = d;

%% (6) Kernel Principal Component Analysis (Complete This Section)
% d --> Desired Number of Features 
d = 5;

% Kernel Type: Linear, Polynomial, Gaussian, etc.
Kernel.Type = 'Laplacian';
Kernel.Parameter = 100;

% Apply Kernel PCA
Data_KPCA = Data;
Data_KPCA.Input = KernelPCA_Incomplete(Data.Input', Kernel, d); 
Data_KPCA.d = d;
%% (6.5) - KPCA
% Weight for Error in Training Data (from 0 to 1)
WeightTrain = 0.5;
% Number of Artificial Neural Network Evaluations
NumExecutions = 50;


% For Kernel PCA
Objective_KPCA = FeatureSelectionObjective(...
    ones(1,Data_KPCA.d), Data_KPCA, WeightTrain, NumExecutions);

%% (7) Comparison of Methods    
% This Section Calculates The Classification Error Using The Selected
% Features With; Errors Can be Compared With Evolutionary Feature Selection
    
% Weight for Error in Training Data (from 0 to 1)
WeightTrain = 0.5;
% Number of Artificial Neural Network Evaluations
NumExecutions = 50;

% For Sequential Forward/Backward Search
Objective_SFBS = FeatureSelectionObjective(...
    SFIndex_SFBS, Data, WeightTrain, NumExecutions);

% For Laplacian Scores
Objective_LS = FeatureSelectionObjective(...
    SFIndex_LS, Data, WeightTrain, NumExecutions);
    
% For Best Individual d Features
Objective_BIdF = FeatureSelectionObjective(...
    SFIndex_BIdF, Data, WeightTrain, NumExecutions);

% For PCA
Objective_PCA = FeatureSelectionObjective(...
    ones(1,Data_PCA.d), Data_PCA, WeightTrain, NumExecutions);

% For Kernel PCA
Objective_KPCA = FeatureSelectionObjective(...
    ones(1,Data_KPCA.d), Data_KPCA, WeightTrain, NumExecutions);





