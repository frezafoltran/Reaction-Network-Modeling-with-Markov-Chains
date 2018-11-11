%% Joao Freza Foltran

%% Markov Chain Processes

%% Simulate Final State Distributions 

% define variables
p = [0.2 0.5 0.3; 0.1 0.4 0.5; 0.1 0.4 0.5];

%p = [0.1 0.8 0.1; 0.1 0.8 0.1; 0.1 0.8 0.1];
i = 1;
n_trans = 5;
n = 10000;



% Plot results
figure (1)
bar(dist_final_states(p,i, n_trans, n));
str=sprintf('Distribution of Final State in %d Transitions with Initial State = %d', n_trans, i);
title(str);
    
%% Communicating States and Closed Set of States
    

p = [0.2 0.8 0; 0.1 0.4 0.5; 0 0 1];


[from, to, Com, isClosed] = comMatrix(p)




