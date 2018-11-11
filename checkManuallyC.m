function [ baseCon, baseSub, temp_b ] = checkManuallyC( range, r )

% This function is used if MatLab solve function cannot solve the system of
% inequalities generated to find any conservation/subconservation vectors
% of CRNs. Given a gamma matrix r (dimensions (nxm)), checkManuallyC checks
% for n-tuples c (with positive entries, within the range {1, range}) if the
% product c * r has all entries equal to zero (conservative) or all entries
% non-positive (subconservative).

% -------------------------------------------------------------------------
% INPUTS:

% - r: Gamma matrix of CRN to be analyzed

% - range: Desired range of n-tuples (the larger the range, the lower
% probability of erros, but the slower the calculation speed.)

% OUTPUTS:

% - baseCon: Base (if any) of conservative vector of CRN

% - baseSub: Base (if any) of subconservative vector of CRN

% - temp_b: Indicator function such that:
% if temp_b = 1: CRN is subconservative;
% if temp_b = 2: CRN is conservative.

% -------------------------------------------------------------------------

% Number of species in CRN
n = size(r,1);

% Initialize outpus
baseCon = zeros(1,n);
baseSub = zeros(1,n);
temp_b = 0;

% Creates all possible n-tuples with values in range:{1, 2...,range}
possibleComb = combnk((1:range), n);

% Now takes all permutations within possibleComb to get:
allPossibleComb = [];

% This loops deals with the permutaions within possibleComb,
% and stores those values in allPossibleComb
for i = 1: size(possibleComb,1)
    
    temp = perms(possibleComb(i,:));
    allPossibleComb = [allPossibleComb; temp];
    
end

% Apend previous possibleComb vector to all PossibleComb
allPossibleComb = [allPossibleComb; possibleComb];

% This include row vectors that contains all entries equal (no 0 row)
for i = 1: range
    temp = ones(1,n);
    temp = temp * i;
    allPossibleComb = [allPossibleComb; temp];
end

% Checks, for all entries (rows) in allPossibleComb (designated by base___),
% if the result of: base___ * r is either equal to zero (all entries), or
% non-positive (all entries)
for i = 1 : size(allPossibleComb, 1)
    
    allPossibleComb(i,:);
    temp = allPossibleComb(i,:) * r;
    
    % Check for Conservation
    if all(temp ==0)
        temp_b = 2;
        baseCon = allPossibleComb(i,:);
        break
    end
    
    % Check for Subconservation
    if all(temp <=0)
        temp_b = 1;
        baseSub = allPossibleComb(i,:);
        break
    end
   
end
end

