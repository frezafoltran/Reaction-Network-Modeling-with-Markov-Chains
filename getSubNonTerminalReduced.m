function [ sub_r ] = getSubNonTerminalReduced( r, i )

% This function generates a sub-set of reactions from a gamma matrix of a
% CRN. The sub-CRN includes all reactions in which the i-th species is not
% part of a non-terminal complex.

% -------------------------------------------------------------------------
% INPUTS:
% -r: Original gamma (reaction) matrix

% -i: Species to be removed (only non-terminal complexes)

% OUTPUTS:
% -sub_r: Gamma matrix for sub-network.

% -------------------------------------------------------------------------

        indexVec = [];
        N = size(r,2);
       
        % Loops through each reaction
        for j = 1 : N
          
            % if i-th species is not part of non-terminal complex, store index
            % of reaction in vector
            if r(i,j) >= 0
                indexVec = [indexVec j];
            end
            
        end
        
        sub_r = r(:, indexVec);
        
        % Now this checks if a species was completely eliminated from the
        % CRN. (i-th species is eliminated iff i-th row of new gamma matrix has
        % all zeros)
        sub_r( ~any(sub_r,2), : ) = [];



end

