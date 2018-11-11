%% Joao Freza Foltran

function [from, to, Com, isClosed] = comMatrix( p )
% comMatrix: This function evaluates whether sets of states are
% communicative or not given a transition probability matrix.

% from: Output that provides a matrix that indicates if a state j can be
% reached from state i. If from(i, j) = 1, i->j, else, if from(i, j) = 0,
% i /-> j

% to: Output that is simply transpose matrix of from. If to(i, j) = 1, 
% j->i, else, if to(i, j) = 0 j /-> i.

% Com: Output that provides the intersection between from and to matrices.
% Elements of Com are 1 if conditions of from and to are true. ie states are
% communicative.

% isClosed: Output that provides a row vector of length equal to the number
% of states. i-th element of isClosed is 1 if Com(i) is closed (which is:
% set formed by states represented by non-zero indexes in Com(i). And Com(i) is
% closed only if it equals from(i).

% Get size of transition matrix

[m, m] = size(p);

% initialize From matrix, should be same size as p

from = zeros(m, m);

% Loop over all m rows of p,
% Start by including element k into the from matrix
% and then for all existing elements in line k of from
% add to from(k) all states j that satisfy k -> j 

for k = 1: m
 
    % include state k in From set (assume k always communicates with k)
    from(k, k) = 1;
    
    % To ensure that not only direct paths are considered, when evaluating
    % transitions (error in first version), create an array a and s, to analyze 
    % every possible transition (with multiple steps), explanation inside
    % next loop
    
    a = [k]; 
    s = zeros(1,m);
    
    % Define reference variables that force entering the loop
    % but that also are manipulated to exit the loop at the correct step
    b1 = 1;
    b2 = 0;
    
    while b1 ~= b2
    
       % Sums all indexes of elements in k-th row of
       % from that do not store 0 (This is to control whether the code
       % below is done adding elements to from(k))
       b1 = sum(find(from(k, :) > 0));
      
       % for the first iteration (of the inside loop) for every k,
       % s is simply a copy of the a-th (k-th) row of p. 
       
       % Afterwards, each element of s will hold the sum of elements
       % that have row numbers indicated by a, and go thorugh all columns
       % of p. Ex: if a = {1, 2} and p has dimension (size) 3, 
       % s = {p11 + p21, p12 + p22, p13 + p23}, ie third row is not added.
       
       % This ensures that a vertical 'grid' is created and scanned through
       % the matrix p in order to indentify multi-step transitions. see
       
       for  i = 1 : m
           
           s(1,i) = sum(p(a,i), 1);
       end
       
       % This stores the indexes of non-zero elements of s into an array
       non_zero = find(s>0);
       
       % Simply get the number of non-zero elements in s
       [ignore, length_non_zero] = size(non_zero);
       
       % Assign the corresponding element in from to 1
       % iterates through indexes stored by non_zero
       from(k, non_zero) = ones(1, length_non_zero);
       
       
       % Sums again to check if loop should re-iterate
       b2 = sum(find(from(k, :) > 0));
       
       % Ensures that a vector on new iteration of loop carries values that
       % will be tested for possibly non-null transition probabilities
       a = non_zero;
    end
    
end

% Takes transpose of to matrix
to = from';

% And creates matrix that gives communicative classes (described above)
Com = to&from;

% takes care of identifying whether Com(i) is closed or not
isClosed = ones(1,m);

% Checks if each row of C and to are equal or not
for i = 1 : m
    
    for k = 1 : m
        
    if Com(i, k) ~= from(i,k)
        isClosed(1,i) = 0;
    end
    
    end
end


end

