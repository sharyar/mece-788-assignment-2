%% Reference
% Part of this code was adopted from: 
% https://www.mathworks.com/matlabcentral/fileexchange/69378-kernel-principal-component-analysis-kpca

% This code was modifies for "MECE 788: Applied Computational Intelligence
% for Engineering" at the Univerisyt of Alberta, Winter 2021.


function [MappedData]= KernelPCA_Incomplete(Input, Kernel, d)
% This Function Performs Kernel PCA On Input Data
% Input Data: M by p Matrix (M: # of Observations, p: # of Features)
% Kernel: Structure Including "Type" and "Parameter"
% "Type" is Kernel Name: Linear, Polynomial, Gaussian, etc
% "Parameter" is Kernel Parameter for Each Kernel Type

% Compute the Kernel Matrix
%%% You Should Complete This Function
K = ComputeKernelMatrix(Input, Kernel); 

% Center Kernel Matrix
OneMatrix = ones(size(K))./size(K,1);
K_center = K - OneMatrix * K - K * OneMatrix + OneMatrix * K * OneMatrix;

% Perform Eigenvalue Decomposition
[EigVec, EigVal] = eigs(K_center/size(K_center,1), size(K_center,1));
lambda = diag(EigVal);

% Sort EigenVectors Using EigenValues
[~, index] = sort(lambda, 'descend');
EigVec = EigVec(:, index);

% Calculate The Mapped Data
MappedData = EigVec(:,1:d)' * K_center;
end

function [K] = ComputeKernelMatrix(X, Kernel)
% This Function Calculates the Kernel Matrix For Input Data X
% More Kernel Functions Can be found at:
% http://crsouza.com/2010/03/17/kernel-functions-for-machine-learning-applications/#linear

% Input Data: M by p Matrix (M: # of Observations, p: # of Features) -
% Reversed 
% Kernel: Structure Including "Type" and "Parameter"

switch Kernel.Type
    case 'Linear'
        K = (X*X').^Kernel.Parameter;
        
    case 'Polynomial' % Write Code for Polynomial Kernel
        K = (1 + X*X').^Kernel.Parameter;
        
    case 'Gaussian'
        sx = sum(X.^2, 2);
        sy = sum(X.^2, 2);
        xy = 2*(X*X');
        K = exp(((xy-sx)-sy')./Kernel.Parameter^2);

        
    case 'HypTan' % Write Code for Hyperbolic Tangent Kernel
        K = tanh(Kernel.Parameter(1) + Kernel.Parameter(2).* X * X');
        
    case 'Laplacian' % Write Code for Laplacian Kernel
        % num of observations
        % our X is (p, m) -> rows are features and columns are obs
        
        m = size(X, 1); % this gives us the number of columns (obs)
        xi_minus_xj = zeros(m);

        for i = 1:m
            for j = 1:m
                xi_minus_xj(i,j) = norm(X(i, :) - X(j, :));
            end
        end
        
        K = exp(xi_minus_xj./(-1 * Kernel.Parameter));
        
    case 'RationalQuadratic' % Write Code for Rational Quadratic Kernel
        % num of observations
        % our X is (p, m) -> rows are features and columns are obs
        
        m = size(X, 1); % this gives us the number of columns (obs)
        xi_minus_xj = zeros(m);

        for i = 1:m
            for j = 1:m
                xi_minus_xj(i,j) = norm(X(i, :) - X(j, :));
            end
        end
        
        xi_minus_xj = xi_minus_xj.^2;
        
        K = (1 - (xi_minus_xj ./ (xi_minus_xj + Kernel.Parameter)));
  
        
    case 'MultiQuadric' % Write Code for MultiQuadric Kernel
        % num of observations
        % our X is (p, m) -> rows are features and columns are obs
        
        m = size(X, 1); % this gives us the number of columns (obs)
        xi_minus_xj = zeros(m);

        for i = 1:m
            for j = 1:m
                xi_minus_xj(i,j) = norm(X(i, :) - X(j, :));
            end
        end
        
        xi_minus_xj = xi_minus_xj.^2;
        
        K = sqrt(xi_minus_xj + Kernel.Parameter);

        
    case 'Power' % Write Code for Power Kernel
        % num of observations
        % our X is (p, m) -> rows are features and columns are obs
        
        m = size(X, 1); % this gives us the number of columns (obs)
        xi_minus_xj = zeros(m);

        for i = 1:m
            for j = 1:m
                xi_minus_xj(i,j) = norm(X(i, :) - X(j, :));
            end
        end
        
        K = -1.* (xi_minus_xj.^Kernel.Parameter);
        
    case 'Log' % Write Code for Log Kernel   
         % num of observations
        % our X is (p, m) -> rows are features and columns are obs
        
        m = size(X, 1); % this gives us the number of columns (obs)
        xi_minus_xj = zeros(m);

        for i = 1:m
            for j = 1:m
                xi_minus_xj(i,j) = norm(X(i, :) - X(j, :));
            end
        end
        
        K = -1 .* log(xi_minus_xj.^Kernel.Parameter + 1);
    
end


end










