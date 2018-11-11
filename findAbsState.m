function [ stringReactions, absState ] = findAbsState( X, init, coef )
% This function finds the absorbing states of any set of reactions.

% INPUTS:
%   X: inputof the coefficients of reactions. Must be in the format:
%      X = [a1 b1 ...A1 A1 ...; a2 b2 ... A2 B2...; ...], in which indexes with 
%      1 correspond to first reaction, 2 to second and so forth. And the a, b, c...
%      coeffiencits correspond to the coefficient associated with each
%      element. Note that each row accounts for both reactants and products,
%      so that: ai, bi... reffer to reactants and Ai, Bi to products. 
%  Ex: For reactions: 2a -> b and a + b -> a, X = [2 0 0 1; 1 1 1 0]

%   init: Gives the initial number of molecules of all reactants in format of a
%         row vector. i.e each column contains initial number of molecules for
%         each element present in reaction.

%   coef: Array that gives the proportionality constants for each reaction. 
%      Must be in format k = (1, nr), for nr reactions. 

% OUTPUTS:
%   stringReactions: Provides the number of molecules of each element after
%   a specific number of reactions have occured:

%   absState: Gives the number of molecules of each reactant after
%   absorbing state has been reached.

% Define number of reactions present
nr = size(X, 1);

% Define number of different elements present
ne = length(init);

% Create array to determine whether all constraints for specific reaction
% are satisfied
compare = ones(ne,1);

% variable to exit loop if no absorbing states are found
exit = 1;

% Defines array of results to store partial values of StringReactions
% and variable k to avoid incrementing result at wrong times
k = 2;
result = zeros(ne,1000);
result(:, 1) = transpose(init);


% Infinite loop that breaks when no reaction can be performed (abs state)
while(1)
   
   % Reinitializes variables to original values ( model each reaction as
   % independent of one another)
   reactionHappened = 0; 
   bol = zeros(ne,nr);
   exitOrNot = 0;
   
   % Deals with calculating probaility of each reaction to happen
   
   % Stores all possible combinations of coefficients given their current
   % number of molecules for each reaction
   p = getAllComb(X, init);
    
   % Stores the resulting parameters for the waiting times for each
   % reaction (models as exponential random variables)
   [ P, W ] = waitingTimes( p, coef );
   
   Pt = transpose(P);
   % Creates array of cum sum of P to later model waiting times:
   cumSumP = cumsum(Pt);
   
   % Checks if any reaction can happen
   % Only can happen if bol() for the corresponding reaction
   % contains ones
   for i = 1: nr
      
       % Loops through all elements present and compares the remaining
       % number of molecules for each one to check if any reaction can
       % still happen. if i-th column of bol has all ones, i-th reaction 
       % can happen  
      for j = 1: ne
        
      % if there's enough reactants for reaction i to happen, i-th column
      % of bol matrix is filled with ones
      if init(j) >= X(i,j)
          bol(j,i) = 1;
      end 
      
      end
   end
   
  % display boolean matrix
   
   % Generates random number between 1 and 0 
   random = rand();
   
   % Models an outcome cs, such that it models the probability of 
   % each reaction to happen
   cs = find(cumSumP >= random, 1);
   
   % Checks concurrently if the probability indicator function indicates
   % certain reaction and if that reaction can happen (based on number of 
   % remaining molecules of each reactant:
   for u = 1: nr
    
   % ERROR This code had a problem for highr dimension matrices
    if ((isequal(bol(:,u),compare) == 1) && (cs == u))
       
       % Later account for all possible implementations
       for z = 1: ne
           
          % Checks all possible increments decrements of each element
          % as the reaction takes place (ne accounts for offset)
          init(z) = init(z) - X(u,z) + X(u, ne + z);

          % Indicator variable for later increment of result
          reactionHappened = 1;

       end
   end
   end
   
   % Deals with modifying result matrix (separate if statement to avoid 
   % overwriting data)
   if reactionHappened == 1
       
       for y = 1: ne
           result(y,k) = init(y);
       end
       
          k = k + 1;
   end
   
   % Takes care of exiting the loop or not:
   % Should exit while loop if no reactions can be perfomed:
   % ie absorbing state has been reached
   for n = 1:nr
       
   % Creates flag variable to check if loop should be exited
   if isequal(bol(:,n),compare) == 0
       
       exitOrNot = exitOrNot + 1;
   end
   end
   
   % Checks if flag meets conditions
   if exitOrNot == nr
      break; 
   end
   
   % This is a temporary statement 
   % Basically, if loop takes more than 100 reaction to find absorbing
   % state, assume there's no abs state and exit loop.
   exit = exit + 1;
   
   if exit > 1000
       break;
   end
    
end

for l = 1: k-1
  
    stringReactions(:,l) = result(:,l);   
end

% if abs state is found, increment to show continuity
absState = 0;


% if there was no reaction, abs state is initial state
% check if there was no reaction
bol = 0;

for o = 1: k-1
  
    if result(:,o) == result(:,1)
       bol = bol + 1; 
    end
    
end


% if abs state was found, assign new value to absState variable
if (exitOrNot == nr) || (bol == k-1)
    for l = k: k + 5
        stringReactions(:,l) = result(:,k-1);
        
        absState = result(:,k-1);
    end
end


end

