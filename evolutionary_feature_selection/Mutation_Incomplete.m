function [Offspring] = Mutation_Incomplete(Parent, mu)
% This Function Perform Bianry Mutation by Changing Some Genes from 0 to 1
% or Vice Versa.

% *********** WRITE YOUR CODE HERE *************
% How Many Genes Must Undergo Mutation (Calculate Using mu)
% NumGenes Must be between 1 and length(Parent)

% Select NumGenes of Parent Randomly
num_genes_to_mutate = ceil(mu * length(Parent));

% permutation function that outputs the num_genes_to_mutate for the number
% of indices and then uses them to flip the specific indices. 
perm_idx = randperm(length(Parent), num_genes_to_mutate);

Offspring = Parent;

% Apply Mutation
for i=1:length(perm_idx)
    % will invert a 1 to 0 and 0 to 1!
    pos = perm_idx(i);
    Offspring(pos) = 1 - Offspring(pos);
end

% **********************************************

% To Make Sure That At Least One Feature Is Selected (Dont need to change
% the following)
if sum(Offspring) == 0
    Offspring = Parent;
end
end 