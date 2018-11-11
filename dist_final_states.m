function [x] = dist_final_states(p, i, n_trans, n)
% dist_final_states This function simulates the final state of a markov
% process given a transition matrix, an initial state and a number of
% transitions. 

% p: input that gives the transition matrix
% i: input that gives the initial state
% n_trans: input for the number of transitions desired
% n: number of simulation times
% x: output that gives a vector of final states (each index (i) represents
% the number of times the chain ended in state i.
%  

% Assign initial state to cs, to not lose its original value
cs = i;

% get length of p and create x vector(with same length of p)
[m, m] = size(p);
x = zeros(1, m);


% for loop that iterates through each simulation (n times)
for j = 1: n
    
% this for loop takes care of individual simulations
for k = 1: n_trans
   
   % Store row of p corresponding to the current state 
   current_dist = p(cs, :);
   
   % Get cumulative sum of current distribution to calcuate 
   % appropriate transition probabilities according to current state
   
   cum = cumsum(current_dist);
   
   % Generate random number to simulate transition
   
   random = rand();
   
   % Stores the index of first number in cum array that is larger than
   % random number generated. This will be the next state (final state in 
   % for the last iteration).
   cs = find(cum >= random, 1);
  
    
end

% increment index of x that corresponds to final state
x(1, cs) = x(1, cs) + 1;

% reinitializes initial state
cs = i;

end

end

