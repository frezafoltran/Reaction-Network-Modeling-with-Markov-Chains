function [ r ] = getBimCrn( nr, ns )

% This function creates a gamma (reaction) matrix for a random bimolecular
% CRN.

% -------------------------------------------------------------------------

% INPUTS:
% - nr: Number of reactions in random CRN

% - ns: NUmber os species in random CRN

% OUTPUTS:
% - r: Gamma matrix for CRN

% -------------------------------------------------------------------------

c = 0;
zero = zeros(ns,1);
b = 0;
size = 0;

% Check which dimension is larger
if nr > ns
    b = 1;
end

if nr == ns
    size = nr;
end

while (1)
    
    % Accounts for non-square matrices
    if b == 0
        temp_r = round(-2 + 4 * rand(ns));
        r = temp_r(:,(1:nr));
    end
    
    if b == 1
        temp_r = round(-2 + 4 * rand(nr));
        r = temp_r((1:ns),:);
    end
    
    if size == nr
       r = round(-2 + 4 * rand(size)); 
    end
        
% Reinitializes counter after every loop
c = 0;

% Loops through reactions to verify if it meets contraints of BM CRN
for i = 1: nr
    flag = 0;
 
    if ns > 2
        
     if sum(r(:,i) == 0)>= 1
         flag = 1;
     end
     
    end
    
    if ns <= 2
       flag = 1; 
    end
    % if neither reaction is null && neither reaction is (Ai -> 0)
    if ~isequal(r(:,i), zero) && ~all(r(:,i) <= 0)
    %if ~all(r(:,i) <= 0)
        
        if flag == 1
        c = c + 1; 
        end
    % end    
    end
    
end

% If constraints are met, exit loop and return r
if c == nr
    break
end

end


end

