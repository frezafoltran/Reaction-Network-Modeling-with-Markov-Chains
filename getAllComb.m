function [ p ] = getAllComb( X, init )

% INPUTS: 
% init: number of molecules of each element at a given time

% X: matrix of coefficients of each reaction.

% OUTPUTS: 
% p: matrix of probability that represents the likelyhood of each
% reaction to happen

% For more detail on parameters, see funciton findAbsStates.m

% METHODOLOGY:

% Model each reaction's waiting time as an exponential rv. As a consequece,
% the minimum waiting time for all reactions is going to have an
% exponential distribution, given by an exponential rv of parameter equal
% to the sum of the parameters of the individual waiting times.

% Also assume that the parameters for the exponential rv of each waiting
% time is proportinal to the number of molecules of each element.

% More specifically, model this situation by considering that the
% parameters for the rv are actually proportional to the number of possible
% combinations between the  reactants of each reaction.

% This function determines the number of possible combinations among the
% reactants for each given reaction (later functions cover the parameter
% aspects of the rv.

% Model it as follows:

% To get the total number of combinations that may happen given
% certain reaction coefficients, it's necessary to sum all coefficients 
% (to figure out how many molecules must be used) and then find out how 
% many of each molecule will be used (by noting different coefficients for 
% different elements). Note the example:

% EX: for reaction => 2a + b -> c, 

% number of molecules that must be used = 3,
% such that, 2 are of type a and 1 of type c. So if there are xa and xb
% molecules of a and b respectively, the total number of combinations
% between a and b to form the necessary reactants is:

% total # combinations = xa * (xa - 1) * xb

% Generalize the algorithm below:

% Gets number of reactions:
nr = size(X,1);

% Gets number of different elements:
ne = length(init);

% Creates array to store total # combinations for each reaction.
difComb = ones(nr,1);

% initialize result
result = 0;

% initialize currCoef variable
currCoef = 0;

% Loops through each line of reactions (this actually calculates all
% possible combinations of elements for each reaction)
for i = 1:nr

   for j = 1: ne
      
       
       currCoef = X(i,j);
       
       if currCoef ~= 0 
           
       % OBS: Handle error to avoid calculating possible combinations when 
       % there are not enough molecules of each element (should, for now, be
       % handled in findAbsState function)
       if init(1,j) >= currCoef
           
       result = nchoosek(init(1,j), currCoef);
       difComb(i,1) = difComb(i,1) * result;
       
       else 
           result = 0;
           difComb(i,1) = difComb(i,1) * result;
       end
              
       end
   end  
end

p = difComb;

end

