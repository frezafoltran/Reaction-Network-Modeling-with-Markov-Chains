function [result] = getConservSubset(r)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Initialize variables
    % Number of species
    n = size(r, 1);
    
    % Number of reactions
    N =size(r,2);
    
    % Possible Conservative CRN (subset of initial CRN)
    conservSub = [];
    
    % Vector to store index of reaction to be removed
    indexVec = [];
    
    %
    result = zeros(1,n);
% First checks if CRN is subconservative or not:
[~, ~, ~, ~, ~, ~, b] = isConservative(r);

% if CRN is subconservative, executes if
if b == 1
    
    % Loops through every species (take out one at a time)
    for i = 1 : n
        
%         indexVec = [];
%        
%         % Loops through each reaction
%         for j = 1 : N
%           
%             % if i-th species is not part of non-terminal complex, store index
%             % of reaction in vector
%             if r(i,j) >= 0
%                 indexVec = [indexVec j];
%             end
%             
%         end
%         
%         indexVec;
%         conservSub = r(:, indexVec);
%         
%         % Now this checks if a species was completely eliminated from the
%         % CRN. (i-th species is eliminated iff i-th row of new gamma matrix has
%         % all zeros)
%         conservSub( ~any(conservSub,2), : ) = [];

[conservSub] = getSubNonTerminalReduced( r, i );
        
        % Checks if sub-set is conservative or not
        [extraCon, extraSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative(conservSub);
        
        if b == 2
           result(1,i) = 1; 
        end  
    end
    
end

end

