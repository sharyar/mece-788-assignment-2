function [Offspring1, Offspring2] = BinaryCrossover_Incomplete(Parent1, Parent2)
% This Function Performs Binary Crossover Operation Including
% Single Point Crossover, Double Point Crossover, Uniform Crossover

% One Crossover Operator Will be Selected In Each Iteration Using
% Roulette Wheel Selection

Offspring1 = [];
Offspring2 = [];

Prob_SPX = 0.15;
Prob_DPX = 0.25;
Prob_UX = 1 - Prob_SPX - Prob_DPX; % Less Probability for SPX and DPX
XMethod = RouletteWheelSelection([Prob_SPX Prob_DPX Prob_UX]);
switch XMethod
    case 1
        [Offspring1, Offspring2] = SinglePointCrossover(Parent1, Parent2);
    case 2
        % (!!!Complete This Function!!!)
        [Offspring1, Offspring2] = DoublePointCrossover(Parent1, Parent2);
    case 3
        % (!!!Complete This Function!!!)
        [Offspring1, Offspring2] = UniformCrossover(Parent1, Parent2);
end

% To Make Sure That At Least One Feature Is Selected
if sum(Offspring1) == 0 || sum(Offspring2) == 0
    if sum(Offspring1) == 0 % Fix Offspring 1
        Offspring1 = Parent1;
    else % Fix Offspring 2
        Offspring2 = Parent2;
    end
end
end

function [Offspring1, offspring2] = SinglePointCrossover(Parent1, Parent2)
% This Function Perform Single Point Crossover

% Select A Random Number
i1 = randi([1 length(Parent1)-1]);
% Perform Crossover
Offspring1 = [Parent1(1:i1) Parent2(i1+1:end)];
offspring2 = [Parent2(1:i1) Parent1(i1+1:end)];
end

% *********** WRITE YOUR CODE HERE *************
function [Offspring1, offspring2] = DoublePointCrossover(Parent1, Parent2)
% This Function Perform Double Point Crossover

% Select Two Random Numbers - implement forced randomness in case numbers
% are the same #TODO - permutation of 1-10! pick the first two numbers
i12 = randperm(length(Parent1)-1, 2);

i1 = i12(1);
i2 = i12(2);

% i1 = randi([1 length(Parent1)-1]);
% i2 = randi([1 length(Parent1)-1]);

if i2 > i1
    Offspring1 = [Parent1(1:i1) Parent2(i1+1:i2) Parent2(i2+1:end)];
    offspring2 = [Parent2(1:i1) Parent1(i1+1:i2) Parent2(i2+1:end)];
else
    Offspring1 = [Parent1(1:i2) Parent2(i2+1:i1) Parent2(i1+1:end)];
    offspring2 = [Parent2(1:i2) Parent1(i2+1:i1) Parent2(i1+1:end)];
end

% Perform Crossover

end

function [Offspring1, offspring2] = UniformCrossover(Parent1, Parent2)
% This Function Perform Uniform Crossover

% Create A Random Mask of 0s and 1s with Similar Length to Parents
il = logical(randi([0,1], [1 length(Parent1)]));
il_invert = ~il;

% Initialize offspring vectors
Offspring1 = zeros([1,length(Parent1)]);
offspring2 = zeros([1,length(Parent1)]);

% Perform Crossover
Offspring1(il) = Parent1(il);
Offspring1(il_invert) = Parent2(il_invert);

offspring2(il) = Parent2(il);
offspring2(il_invert) = Parent1(il_invert);

end
% **********************************************

function [Index] = RouletteWheelSelection(P)
% This function performs Roulette Wheel Selection
% based on given probabilities P

i = rand; % Select a random number
C = cumsum(P); % Cumulative sum of P
Index = find(i <= C, 1, 'first');
end









