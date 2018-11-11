function [ test, r ] = algorithmTest( nr, ns )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Avoid species that are only being consumed since case is too trivial
test = 0;
while (test ~= 1)
    
while (1)
    
[r] = getBimCrn(nr,ns);

test = all(r((1:ns),:) <= 0);

zero = zeros(1,nr);

if isequal(test,zero)
   break 
end

end

% ------
% Parameters:
% nr = 4;
% ns = 4;

% (1): Find most negative row sum in gamma matrix (identifies species 
% potentially being consumed the most)

sumArray = zeros(1,ns);
% sumArray(1,(1:ns)) = sum(r((1:nr),:), 2)
sumArray(1,(1:ns)) = sum(r((1:ns),:), 2);

% mostCons carries the index of most consumed species(could be more than
% 1) in CRN 
% (when singular, denote it by species i)
mostCons = find(sumArray == (min(sumArray)));

% Examine the reactions that produce i. If the reactants of that (those)
% reaction are being overall consumed or not changed (given by sum of
% rows), test to see if i would run out. 

if length(mostCons) == 1
    
produce_i = find(r(mostCons,:) > 0);

% reactants carries the index of species being consumed to produce i
reactants = find(r(:, produce_i) < 0);

for i = 1 : length(reactants)
    
    if reactants(i,1) > ns
       reactants(i,1) = reactants(i,1) - ns ;
    end
end

if sumArray(1,(reactants)) <= 0
    % Avoids synthesis reaction
    if isequal(zero,all(r(:,(1:nr)) >=0))
        
    % Add condition to check for subconservation and whether sub set is 
    % conservative(in parenthesis)
    % [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r );
    % [result] = getConservSubset(r);
    % if b == 1
        % if ~isequal(result, zero)
            test = 1;
        % end
    % end
    
    
    end
end
end
end

end

