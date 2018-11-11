function [ P, W ] = waitingTimes( p, k )

% INPUTS: 
% p:  is a matrix of all possible combinations between reactants of
% each reaction (in format of column vector (j,1) for j reactions)

% k: gives the constants of proportionality for the parameters of the
% exponential random variables (in format of column vector (j,1) for j reactions)

% OUTPUT:
% P: Gives the parameters for the waiting times of each reaction
% (in format of column vector (j,1) for j reactions)

% W: Parameter of rv for minimum waiting time

% Note that all waiting times are modeled as exponential random variables,
% and that the resulting minimum waiting time is modeled as another
% exponential rv that has parameter equal to the sum of all individual
% parameters

% This function basically calculates individual waiting times and minimum
% waiting time by applying basic knowledge of the exponential random
% variable:

% Define P to carry the parameters for i-th reaction in row i:
P = ones(length(p), 1);

% Creates r to include constants of proportionality to matrix p:
r = ones(length(p), 1);

% Define number of reactions
nr = size(p, 1);

% Set values to array r
for j = 1: nr
   
    r(j,1) = p(j,1) * k(j,1);
    
end

% Also define sum array to carry sum of all r(:,1)
resultingSum = sum(r(:,1));

% Set values to P
for i = 1: nr
   
    P(i,1) = r(i,1)/(resultingSum);
    
end

% Define sum of individual parameters to model minimum waiting time:
W = sum(P(:,1));


end

