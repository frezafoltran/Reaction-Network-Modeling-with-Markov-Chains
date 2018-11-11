function [ complexCom ] = getComplexCom(complexMat, M, n)
% Generate a matrix to represent the communication between
% different complexes in the system (call if ComplexCom).

% The format of ComplexCom is similar to a standard transition probability 
% matrix. But now, consider each state to be a different complex. And also,
% if one complex communicates with another, the entry for that term is 1. 

% Notice:

% - The term 'communicates', in this context reffers to either a one way 
% communication, unlike when dealing with transition probability matrices.

% - Rows in the complexCom matrix may add up to more than 1, unlike
% transition probability matrices.

% ------------------------------------------------------------------------
% OUTPUT:
% - complexCom: square matrix with dimensions nxn, given that n is
%               the number of different complexes (more detailed description
%               above).

% INPUTS: 
% - complexMat: Matrix of all distinct complexes in network.
%               Different rows represent different complexes and different 
%               rows represent different species in each complex.

% - M: Network reaction matrix (each row represents each reaction and columns 
%      represents the coefficients of each species as a product or reactant)

% - n: Number of different complexes present in network

% -------------------------------------------------------------------------

% Gets number of differen species in network
l = size(M,2)/2;

% m is a matrix to represent the reactions in a higher level of abstraction
% It does so by substituting the actual complexes by a number that labels each 
% complex. For example, is a network has 3 different complexes, each
% complex is represented in m by the numbers 1 2 or 3.
m = zeros(size(M,1),2)

% The following loops are to construct matrix m as described above.
% Together, the loops go through each complex in M and compare them to the
% matrix of distinct complexes (complexMat). By assuming that the complexes
% are labeled in increasing order as they appear in complexMat, matrix m is
% constructed accordingly. 

for i = 1 : size(M,1)
   
    u = 1;
    for j = 1 : l : l + 1
     
        for k = 1 : size(complexMat,1)
           
            if isequal(complexMat(k,:), M(i,(j: l+j-1)))
               
                m(i,u) = k;
                
            end
        end
        u = u + 1;    
    end
end

% Now, to construct the output, start by initializing it as an nxn matrix
complexCom = zeros(n,n);

% By observing that entry (i,j) in complexCom will only be 1 if there is a
% pair that corresponds to values (i,j) in m, construct output as follows: 
for i = 1 : size(m,1)
    
       complexCom(m(i,1),m(i,2)) = 1;
    
end



end

