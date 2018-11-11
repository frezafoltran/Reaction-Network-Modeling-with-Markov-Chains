%% Joao Foltran

%% Calculating Deficiency
% % Main goal here is to find algorithm to calculated the deficiency of a
% % bimolecular network of reations:
% 
% % Ex: (where each row represents each reaction and the each column 
% % represents each species' coefficients, notice that first half of columns
% % represents reactants and second half, products.)
% 
% % Reaction Network Matrix: 
% 
% M = [1 1 0 0 0 0 0 0 0 1 0 0 0 0;
%      0 0 1 0 0 0 0 0 0 0 1 1 0 0;
%      0 0 1 0 0 0 0 0 0 0 0 0 2 0;
%      0 0 0 0 0 2 0 0 0 1 0 0 0 0;
%      1 0 0 0 0 1 0 0 0 0 0 0 0 1;
%      0 0 0 0 0 0 1 1 0 0 0 0 1 0];
%  
% %  M = [1 1 0 0 0 0 2 0;
% %       0 0 0 1 1 0 0 0;
% %       0 0 2 0 0 1 0 0;
% %       0 0 2 0 1 0 0 1;
% %       1 0 0 1 0 0 2 0];
%               
% % To calculate deficiency, it's necessary:
% % - Number of complexes (n)
% % - Number of linkage classes (l)
% % - Dimension of Stochiometric subspace (s)
% 
% % to get: {deficiency = (n - l - s)}
% 
% % TO GET THE NUMBER OF COMPLEXES (n):
% 
% [n, distinctComp] = getNumComplexes(M)
% 
% % Note:
% % - While n gives the number of distinct complexes,
% % distinctComp gives a matrix of these distict complexes
% 
% % TO GET THE NUMBER OF LINKAGE CLASSES (l):
% 
% complexCom = getComplexCom(distinctComp, M, n)
% 
% [l] = getLinkageClasses( complexCom )
% 
% % TO GET DIMENSION OF STOCHIOMETRIC SUBSPACE (s):
% 
% % First get the set of reaction vectors for network, then
% % simply use rank function to check for linear dependence.
% % rank method returns number of linear independent rows of a matrix
% % which in this case is denoted by the dimension os the stochiometric 
% % subspace.
% 
% reactionVectors = getReactionVectors(M)
% 
% s = rank(reactionVectors)
% 
% % Finally get defficiency by combining these functions:
% 
% d = (n - l - s);

%% Absorbing States

%% Conservation / Subconservation Vectors

% Sub
r = [0 -1 1; -1 1 -1];

% Neither
% r = [-1 2; 2 -1];

% Is it Conservative? c has one or more 0 elements
% r = [-1 0; 1 0; 0 1];
% 
% % Same question as above
% r = [0 -1 1; -1 1 -1; 0 1 -1];

% r = [1 1 -1 0;
%      0 -1 1 0;
%      1 0 -1 2;
%      -2 1 1 -2];

% Examples for Conservative subsets of Subconservative CRNs

% (1)
r = [-1 -2  0  0  1;
     -1  1  1 -1  0;
      1  0 -1  1  0;
      0  0  0  0 -1];
% (2) 
r = [1  0  1;
    -1  2  0;
     0  0  2;
    -1 -1 -1];

% (3) Does not fit requirements, but interesnting case

r = [-1 -2  0   1;
     -1  1  1   0;
      1  0 -1  -1;
      0  0  1  -1];

% -------------------------------------------------------------------------
  
% r = [-1 -2 0 0;
%      -1 1 1 -1;
%      1 0 -1 1;
%       0 0 0 0];

r = [1 2 -1 1;
    -1 0 2 -3;
     0 -2 3 0];


  

%% Test of Relation Between Conservative Sub Sets of Sub Conservative CRNs

r = [1 2 -1 1;
    -1 0 2 -3;
     0 -2 3 0];
 
% [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r )

% Testing results:
% [result] = getConservSubset(r)

% Code for getConservSubset seems to be working fine, now to try to
% imlement it into something more useful, observe that:

% - if i-th element of result matrix is one, this means that i-th element
% of CRN is reducing (possibly), and hence an absorbing state or
% equilibrium state must exist in the overall CRN.

%%  Simple code to generate random CRNs to test algortihms (Bimolecular) 

% Parameters as (nr,ns)
% r = getBimCrn(4,4)

% [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r )

% Testing results:
% [result] = getConservSubset(r)

%% Algorithm for Finding Absorbing States (Tentative)

% (1)
r = [-1 -2  0  0  1;
     -1  1  1 -1  0;
      1  0 -1  1  0;
      0  0  0  0 -1];
% (2) 
r = [1  0  1;
    -1  2  0;
     0  0  2;
    -1 -1 -1];

% (3) Does not fit requirements, but interesnting case

r = [-1 -2  0  1;
     -1  1  1  0;
      1  0 -1 -1;
      0  0  1 -1];
  
 % Test with random CRNs
% Avoid species that are only being consumed since case is too trivial
% test = 0;

nr = 3;
ns = 3;
test = 0;
extra = 0;
% while (test ~= 1)


result = [];
count = 0;
while count < 50
    
while (1)
 
extra = 0;

r = getBimCrn(nr,ns)

% Checks if there is any extinction reaction
test = all(r((1:ns),:) <= 0);
zero = zeros(1,ns);
if isequal(test,zero)
   % break
   %extra = extra + 1;
end

% Checks if there is any synthesis reaction
test = all(r((1:ns),:) >= 0);
if isequal(test,zero)
   % break
   %extra = extra + 1;
end

% Avoids species being only produced
test = all(r >=0 ,2);
zero = zeros(ns,1);
if isequal(test,zero)
   % break
   % extra = extra + 1;
end

% Avoids species being only produced
test = all(r <=0 ,2);
if isequal(test,zero)
   % break
   % extra = extra + 1;
end

[baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative(r);

if extra == 0
    if b ~= 0 
count = count + 1;
string = 'b';

string = strcat(string,int2str(r(1,1)));
string = strcat(string,',');
string = strcat(string, int2str(r(1,2)));
string = strcat(string,',');
string = strcat(string, int2str(r(1,3)));

string = strcat(string, '.');

string = strcat(string, int2str(r(2,1)));
string = strcat(string,',');
string = strcat(string, int2str(r(2,2)));
string = strcat(string,',');
string = strcat(string, int2str(r(2,3)));

string = strcat(string, '.');

string = strcat(string, int2str(r(3,1)));
string = strcat(string,',');
string = strcat(string, int2str(r(3,2)));
string = strcat(string,',');
string = strcat(string, int2str(r(3,3)));

string = strcat(string, 'e');

result = [result; string];
    break
    end
end


end

end

r = [1 2 1; 1 3 2; 3 2 1];

result


% ------
% Parameters:

% (1): Find most negative row sum in gamma matrix (identifies species 
% potentially being consumed the most)
% 
% sumArray = zeros(1,ns);
% sumArray(1,(1:ns)) = sum(r((1:nr),:), 2);
% 
% % mostCons carries the index of most consumed species(could be more than
% % 1) in CRN 
% % (when singular, denote it by species i)
% mostCons = find(sumArray == (min(sumArray)));
% 
% % Examine the reactions that produce i. If the reactants of that (those)
% % reaction are being overall consumed or not changed (given by sum of
% % rows), test to see if i would run out. 
% 
% if length(mostCons) == 1
%     
% produce_i = find(r(mostCons,:) > 0);
% 
% % reactants carries the index of species being consumed to produce i
% reactants = find(r(:, produce_i) < 0);
% 
% for i = 1 : length(reactants)
%     
%     if reactants(i,1) > ns
%        reactants(i,1) = reactants(i,1) - ns;
%     end
% end
% 
% if sumArray(1,(reactants)) <= 0
%     % Avoids synthesis reaction
%     if isequal(zero,all(r(:,(1:nr)) >=0))
%         
%     % Add condition to check for subconservation and whether sub set is 
%     % conservative 
%     [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r );
%     [result] = getConservSubset(r);
%     if b == 1
%         if ~isequal(result, zero)
%             test = 1
%         end
%     end
%     
%     
%     end
% end
% end
% end



% r = getBimCrn(3,3)

% [r] = getBimCrn(3,2)
% f = 0;
% 
% for k = 1 : 100
%     
% [test, r] = algorithmTest(4,4);
% 
%  nr = 4;
%  ns = 4;
%  
% % Convert Gamma to C
% C = zeros(nr, 2 * ns);
% 
% for i = 1 : ns
%    
%     for j = 1 : nr
%        
%      if r(i,j) < 0
%          C(j, i) = -r(i,j);  
%      end
%      
%      if r(i,j) > 0
%          C(j,ns + i) = r(i,j);
%      end
%      
%     end    
% end
% 
% 
% X = [100 100 100 100];
% 
% k = [1; 1; 1; 1];
% 
% [string, abs] = findAbsState( C, X, k, 1 );
% abs
% 
% if all(abs>=0)
%     f = f + 1
%     r
%     
% end
% 
% end


%% Documentation for Perfomed Experiments

%--------------------------------------------------------------------------
%% (1) - A3 is most consumed species (with synthesis reaction)

% r = [2     1     0     0;
%      0     0    -1     1;
%      2    -2     1    -2;
%      0    -1     1     0]

% Coefficient of Extiction (ce):
% - A1 = 3
% - A2 = 0
% - A3 = -1
% - A4 = 0
% Since there is a synthesis reaction (0 -> Ai) in A3 and A1, 
% assume that these species will always be present.

% This implies that reaction 4 will always fire, giving an indefinite
% production of A2. But reaction 3 fires as long as there is A2 present,
% which produces A3 and A4, which in turn, combine with the indefinite
% production of A3 by reaction 1, fire reaction 2. 

% This relationship between terminal and non-terminal complexes, gives rise
% to no absorbing state. In turn, observe that in the long term:

% A1 -> infinite (it is not being consumed and its production does not 
% depend on anything)

% A2, A3, A4 -> vary by small amounts *

% * The reason for that is that all A2, A3, A4 have ce equal to 0, except A3.
% In the case of A3, ce = -1, but reaction 1 (which fires with higher probability,
% when the number of molecules of A2, A3, A4 is small, produces 2 molecules of A3,
% which seems to balance out the number of molecules of A2, A3, A4).

% Is this always the case? Prove required.

% NO ABSORBING STATE, NO EXTINCTION EVENT

%% (1).a (same as above but without synthesis reaction)

% Consider the CRN above modified to give:
% r = [1     0     0;
%      0    -1     1;
%     -2     1    -2;
%     -1     1     0]

% Now since there is no synthesis reaction, 
% Coefficient of Extiction (ce):
% - A1 = 1
% - A2 = 0
% - A3 = -3
% - A4 = 0

% Notice that, the species with most negative ce (A3) is being produced only in
% reaction 2. This reaction has Cn2 = {A2}, which in turn has ce = 0.

% Hence, as suggested, there is an absorbing state in A3, which goes to 0 or
% 1. Since the production of A2 depends on A3, there is also an absorbing
% state in A2, which goes to 0. Cosidering now that neither reaction can
% fire if X = (X1, 0, 0, X4) or X = (X1, 0, 0, X4), there is an absorbing
% state for the entire CRN, in which X1 and X4 depend on initial
% conditions.

% -------------------------------------------------------------------------
%% (2) - A2 is the most consumed species (with sythesis reaction)

% r = [-2     2    -1     1;
%      -1    -1     1     0;
%       0     0     1     0;
%       1     0     0     2];

% Coefficient of Extiction (ce):
% - A1 = 0
% - A2 = -1
% - A3 = 1
% - A4 = 3

% In this example, notice that there is also a sysnthesis reaction (0 -> Ai)
% When analysing it, notice that there will always be A1 and A4 in the
% network. Hence, reaction 3 will always fire, which in turn causes
% reaction 2 to fire, which in turn causes reaction 1 to fire. 

% In the long term, the number of molecules of:

% A3 and A4 -> grow infinetly

% A1 and A2 -> rover around small numbers

% The reason for the A1, A2 case is most likely:
% There is an indefinite production of A1, hence reaction 3 is more likely
% to fire (within 1,2,3). When reaction 3 fires, there is large production of A2
% If we consider A1 and A2 large enough, reaction 1 is more likely to
% happen than 2. Given this order of increasing probability (p4 > p3 > p2 > p1),
% it is logical to consider that p2 >> p1 and p3 >> p1 because A1 grows indefinetly
% so given that ce for A1 in r2 and r3 is 1 and ce for A2 in r2 and r3 is
% 0, it is likely that X1 > X2 in the long term (probability ~ 0.7)

% -------------------------------------------------------------------------

%% (3) A1 is the most consumed species (without synthesis reaction)

% r = [0    -2     1    -2;
%      1     0    -2     0;
%      2     1     0    -1;
%     -1     1    -1     1];

% Coefficient of Extiction (ce):
% - A1 = -3
% - A2 = -1
% - A3 = 2
% - A4 = 0

% First, notice that A1 is the species with most negative ce, hence we
% start the analysis by looking into the reaction(s) that produce A1.
% In this case, only r3 produces A1.

% Notice that the Cn3 = {A2, A4}, which both contain ce <= 0. 

% By taking the sub-set with R' = {r1, r2, r4}, notice that CRN(C,R',S) is
% subconservative, and by taking [result] = getConservSubset(r), notice
% that species A1 is the one that is nonincreasing. 

% Hence, notice an absorbing state for A1 (either X1 = 0 or X1 = 1).

% As a consequence, r2 and r4 cannot fire anymore, which stops the
% production of A4 and hence stops the production of A1 (r3 cannot fire anymore)

% Finally, r1 will fire until X4 = 0, causing extinction event in A4. 

% Why does X2 seem to always be 2 in long term?
% Why does X3 grows in long term

% r = [0    -2   -2;
%      1     0    0;
%      2     1   -1;
%     -1     1    1];

% [baseCon, baseSub, dummyS, conditionS, dummyC, conditionC, b] = isConservative( r )

%% Series of more automated tests:

% -------------------------------------------------------(1)

% r =  0     0     0    -1
%     -2     1    -2     0
%      1     1     1     2
%      0    -2    -2     2

% -A2 has smallest ce
% -A4 is only reactant in Cn2 (non-terminal complex of reaction 2)

% Things to analyze:

% -Sub-set of reactions ,r3, r4, that have A4 in one of their complexes (but are 
% not producing A2) is conservative. [(2*x + 2*y), (x/2 - y), (x), (y)],
% for 2*y < x & 0 < y

% Production of A4 depends on A1, which is not produced, this leads to
% extiction event in the form:

% A1 -> 0  => A4-> 0 => A2 -> 0 => A3 -> grows indefinetly

% -------------------------------------------------(2)

% r =  1     0     1    -1
%      0    -1    -1     1
%     -2     1    -1    -1
%      1     1     0     0

% A3 has smallest ce (= -3)
% Production of A3 depends on A2,
% Production of A2 depends on A1 and A3
% Production of A1 and A3 depends on A2 and A3,

% -Sub-set of reactions ,r3, r4, that have A2 in one of their complexes (but are 
% not producing A3) is subconservative. c = [ u + x1 + x2, x1, x2, x3]
% for 0 < u + y + z & u <= 0 & 0 < x1 & 0 < x2 & 0 < x3 & y - z <= u + y + z

% Leads to extiction event in form:
% A2 -> 0  => A3, A1 -> 0 => A2 -> grows, but then goes to 0 => A3 -> grows indefinetly

% ------------------------------------------------------------(3)

% r =  0     2     0    -2
%      2     0    -1     1
%     -2     1    -1    -2
%     -2    -1     2     0

% A3 has smallest ce (= -4)
% At r2, only A4 is being consumed. Subset for reaction with A4 except r2
% is: Conservative, 
% dummyC = [ z2/2 - z1/2, z1 + z2, z1, z2] 
% conditionC = z1 < z2 & 0 < z1
% 

% ------------------------------------------------------------(4)

% r =  0     0     1     1
%      2    -1     0     0
%      0     1    -2     1
%     -1    -2     1    -1

% A4 is the one with smallest ce (= -3)
% At r3, only A3 is being consumed. Subset of reactions with A3 except r3
% is: Conservative:
% dummyC = [ z2 - z1, z1 - 2*z2, z1, z2]
% conditionC = z1 < z2 & 2*z2 < z1

% ------------------------------------------------------------(5)

% r =  2     2     0     1
%     -1    -2     1    -1
%      0     0    -1     0
%      0     0     1     0

% A2 is the one with smallest ce (= -3)
% Only A3 is being consumed to produce A2. Subset of reactions with A3
% except r3 is: Empty set
% ------------------------------------------------------------(6)

% r =  0     2     0     1
%      1    -2    -2     0
%     -1     0     2    -1
%     -2     2    -1    -1

% A2 is the one with smallest ce (= -3)
% A4 and A3 are reactants at r1. Subset of reactions with A4 and A3 except
% r1 is: Conservative:
% dummyC =
% [ z1 + z2, z1 - z2/2, z1, z2]
% conditionC =
% z2 < 2*z1 & 0 < z2
% ------------------------------------------------------------(7)

% r =  0     0     1     0
%     -1     0    -1     0
%      1    -1    -2    -2
%      1     2     0     1
% ------------------------------------------------------------(8)
% r =
% 
%      1     0     1     2
%      0     2    -2     0
%     -1    -2     0     1
%     -1     2    -2    -2
% ------------------------------------------------------------(9)
% r = -1     1    -2    -2
%      0     0     0     1
%      1     1     0     2
%      0    -2     1     0

% ------------------------------------------------------------(10)
% r =  1     0    -1    -1
%      0    -1     2     0
%     -2     1     0     2
%     -2    -2     0     2



