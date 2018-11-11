function [n, distinctComp] = getNumComplexes( M )
% [ n, complexMat ] = getNumComplexes( M )
% Function to get the number of complexes in any reaction network

% ------------------------------------------------------------------------
% OUTPUT: n = number of complexes in network given by matrix M

% INPUT: M = Matrix that represents reaction network (each column corresponds
% to  each reaction in network)

% ------------------------------------------------------------------------

% Gets number of different species in network
l = size(M,2)/2;

% Gets number of different reactions in network
m = size(M,1);

% Combine different complexes into a column vector
% i.e. one complex per row

complexes = [M(:,(1:l));M(:, (l + 1:2*l))]

[distinctComp, indexComp, ~] = unique(complexes, 'rows');

n = length(indexComp);

% ----------------- OLD CODE -----------------------------------
% % count variable to be used to determine if complex is new or not
% c = 0;
% 
% % This returns the number of different complexes in system
% n = 1;
% 
% % Initialize matrix to store distinct complexes
% % Length is 2*m, becasue that's the largest 
% % number of distinct complexes network can have
% complexMat = zeros(2*m,l);
% 
% % Store refference complex at first row:
% complexMat (1,:) = complexes(1,:);
% 
% % Loops through all complexes of system
% for i = 2: size(complexes,1)
%     
%     % Reinitializes count variable for every loop 
%     c = 0;
%     
%     % Inner loop compares every complex to each other
%     % and then increments n variable when new (different)
%     % complex is found
%     for j = i-1: -1 : 1
%        
%         % if current complex is different than complex at (j,:),
%         % increment c variable 
%         if isequal(complexes(i,:),complexes(j,:)) == 0
%             c = c + 1;
%         end
%             
%     end
%     
%     % If complex is new, c will be incremented for every iteration of the
%     % second for loop and hence, c will equal (i-1)
%     if c == (i-1)
%         n = n + 1;
%         complexMat(n,:) = complexes(i,:); 
%     end 
%     
% end
% 
% zeroMatrix = zeros(1,l);
% c2 = 0;
% 
% % Account for unused rows in complexMat:
% for i = 1 : size(complexMat,1)
%    
%     if isequal(complexMat(i,:),zeroMatrix)
%        c2 = c2 + 1; 
%     end
% end

% complexMat = complexMat((1:(2*m)-c2),:);

% TEST 

% Utilize unique function to identify repetitive complexes.
% distinctComp gives the all the distinct complexes and length(indexComp)
% gives how many distinct complexes there are.
% ----------------------- OLD CODE ----------------------------------------




end

