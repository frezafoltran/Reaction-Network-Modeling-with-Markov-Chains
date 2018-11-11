function [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r )

% This function is used to determine the basis (if any) for conservative or
% subconservative vetors (c) of a CRN. It does so by primarily solving
% a system of inequalities (with MatLab funtion solve). But if this method
% fails, which it often does for CRNs with 4+ species, it checks for c by
% using the function checkManuallyC.

% -------------------------------------------------------------------------
% INPUTS:

% - r: Gamma matrix of CRN to be analyzed

% OUTPUTS:

% - baseCon: Base (if any) of conservative vector of CRN

% - baseSub: Base (if any) of subconservative vector of CRN

% - b: Indicator function such that:
% if b = 0: CRN is neither conservative or subconservative;
% if b = 1: CRN is subconservative;
% if b = 2: CRN is conservative.

% - dummyS: Vector of dummy variables used in represenatation of base for 
% subconservative vector c.

% - conditionS: Set of constraints for dummyS variables to form
% subconservative basis for CRN.

% - dummyC: Vector of dummy variables used in represenatation of base for 
% conservative vector c.

% - conditionC: Set of constraints for dummyS variables to form
% conservative basis for CRN.

% -------------------------------------------------------------------------


% Number of species 
n = size(r,1);

% Number of reations
N = size(r,2);


% Initially, since there is no c vector, b is neither conservative nor
% subconservative.
b = 0;

% Initialize variables:
baseSub = zeros(1,n);
baseCon = zeros(1,n);

dummyS = [];
conditionS = [];
dummyC = [];
conditionC = [];
conds = [];


%% Check for Conservation

% Only runs code if CRN is not null

if n > 0 && N > 0
    
% Limits length of CRN to have 5 different species.
syms x y z w a integer;

% All entries in c vector must be positive.
assume(x>0 & y >0 & z>0 & w>0 & a>0);

% Generate conditions (inequalities) in for loop
for i = 1 : N
    
    % column vector to contain i-th reaction in r
    temp = r(:,i);
    
    % Perfoms element by element multiplication between variables and
    % coefficients of i-th reaction.
    if n == 2
        vec = sum ([x y].*temp');
    end
    
    if n == 3
        vec = sum ([x y z].*temp');
    end
    
    if n == 4
        vec = sum([x y z w].*temp');
    end
    
    if n == 5
        vec = sum([x y z w a].*temp');
    end
    
    % In this case, all entries must equal 0
    cond = (vec == 0);
    
    % Apends condition to vector of conditions
    conds = [conds cond];
    
end

% Following needs if statements for different n 
% **(needs smart way to deal with this)**

if n == 2
    sol = solve(conds, [x y], 'ReturnConditions', true);
    dummyC = [sol.x sol.y];
end

if n == 3
    sol = solve(conds, [x y z], 'ReturnConditions', true);
    dummyC = [sol.x sol.y sol.z];
end

if n == 4
    sol = solve(conds, [x y z w], 'ReturnConditions', true);
    dummyC = [sol.x sol.y sol.z sol.w];
end

if n == 5
    sol = solve(conds, [x y z w a], 'ReturnConditions', true);
    dummyC = [sol.x sol.y sol.z sol.w sol.a];
end

% Sets conditions to output variable
conditionC = sol.conditions;

% If there is a solution, set flag to 2
if ~isempty(conditionC)
    b = 2;
end

%% Checks for Sub-Conservation

% TEST for subconservative CRN

if b ~= 2
    
    % conds is array of each individual condition
    % for N reactions CRN, N conditions must be met.
    conds = [];
    
    % deal with multi length vectors
    syms x y z w a integer;
    
    assume(x>0 & y >0 & z>0 & w>0 & a>0);
    
    % Generate condition in for loop
    for i = 1 : N
        
        % column vector to contain i-th reaction in r
        temp = r(:,i);
        
        % Perfoms element by element multiplication between variables and
        % coefficients of i-th reaction.
        if n == 2
            vec = sum ([x y].*temp');
        end
        
        if n == 3
            vec = sum ([x y z].*temp');
        end
        
        if n == 4
            vec = sum([x y z w].*temp');
        end
        
        if n == 5
            vec = sum([x y z w a].*temp');
        end
        
        cond = vec <= 0;
        
        conds = [conds cond];
        
    end
    
    % Following needs if statements for different n
    % **(needs smart way to deal with this)**
    
    if n == 2
        sol = solve(conds, [x y], 'ReturnConditions', true);
        dummyS = [sol.x sol.y];
    end
    
    if n == 3
        sol = solve(conds, [x y z], 'ReturnConditions', true);
        dummyS = [sol.x sol.y sol.z];
    end
    
    if n == 4
        sol = solve(conds, [x y z w], 'ReturnConditions', true);
        dummyS = [sol.x sol.y sol.z sol.w];
    end
    
    if n == 5
        sol = solve(conds, [x y z w a], 'ReturnConditions', true);
        dummyS = [sol.x sol.y sol.z sol.w sol.a];
    end
    
    conditionS = sol.conditions;
    
    % if there is subconservative vector, set flag to 1
    if ~isempty(conditionS)
        b = 1;
    end
end

%% Checks Manually for Conservation/Sub-Conservation

    [warnmsg, ~] = lastwarn;
    
    % if MatLab's solve function cannot find solution for set of inequalities,
    % solve it manually using checkManuallyC
    % Also, just to avoid errors, this code runs if CRN was not found to be
    % conservative or subconservative.
    
    % This if statement might be faulty (it might be executing even when 
    % subconservation or conservation have been found)
    if (strcmp(warnmsg,'Cannot find explicit solution.') | (isempty(conditionS) & isempty(conditionC)))
        
        % Sets range of n-tuples within checkManuallyC
        range = 10;
        
        % Run code for direct comparisson
        [baseCon, baseSub, temp_b] = checkManuallyC(range, r);
        
        % Output temp_b flags if CRN is conservative or subconservative.
        b = temp_b;
        
    end
    
end





end

