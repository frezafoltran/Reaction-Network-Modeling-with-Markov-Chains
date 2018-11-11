%% Existance/Reachability of Absorbing States

% Coeficcients of reactions:

% Example (no abs state)
C = [2 0 3 1 1 1 3 2;
    1 0 2 1 0 2 1 0; 
    2 2 1 0 2 8 3 7; 
    1 2 1 2 4 0 1 2];

C = [1 1 0 0 2 0;
     0 1 1 2 0 0;
     1 0 1 0 2 0];
 
 C = [0 0 0 2 1 0 1 0;
      0 1 0 0 1 0 0 1;
      1 0 1 0 0 1 0 1;
      0 0 0 2 0 0 2 0];
  
  % Equilibrium case for subconservative CRN
  C = [1 1 0 0 0 0 1 0;
       2 0 0 0 0 1 0 0;
       0 0 1 0 0 1 0 0;
       0 1 0 0 0 0 1 0;
       0 0 0 1 1 0 0 0];
 
  C = [1 1 0 0 0 0 1 0;
       2 0 0 0 0 1 0 0;
       0 0 1 0 0 1 0 1;
       0 0 1 1 1 0 0 0];
   
C = [1 0 0 0 0 1 0 0;
     1 0 0 0 0 0 1 1;
     0 0 2 0 1 2 0 0;
     0 1 0 0 0 0 1 0];
 

 r = [-1 -1 1;
      -1 1 0;
       1 -1 -1];
 
 nr = 3;
 ns = 3;
 
% Convert Gamma to C
C = zeros(nr, 2 * ns);

for i = 1 : ns
   
    for j = 1 : nr
       
     if r(i,j) < 0
         C(j, i) = -r(i,j);  
     end
     
     if r(i,j) > 0
         C(j,ns + i) = r(i,j);
     end
     
    end    
end


 

X = [100 100 100];

k = [1; 1; 1];

% finds absorbing states for set of reactions (0 -> randomize results)

[string, abs] = findAbsState( C, X, k, 1 );
% string(:,(1:100))
% string(:,(4900:5000))

% o = 0;
%for k = 4900 : 5000
%    
%     if string(1,k) > string(2,k)
%         o = o + 1;
%     end
%     
% end



% Plots graph
displayGraph(string, X, transpose(abs), 1);

C


%% Bimolecular Networks
% 
% C = [1 0 1 1; 2 3 1 0];
% 
% % new value
% C = [0 1 1 0; 2 0 0 1];
% 
% X = [10 10];
% 
% ne = length(X);
% nr = size(C, 1);
% 
% % Only one reaction will be perfomed at a time
% k = [1];
% 
% % Define reaction matrix (function also gives columns that contain
% % non-positive values, if any)
% [rm, zn] = getReactionMat(C)
% 
% % If any column in rm is composed of only non-positive elements, consider
% % elements correspondent to those columns first.
% 
% c = 0;
% for k = 1: length(zn)
%     
%    if zn(k, 1) ~= 0
%     
%        c = c + 1;
%        
%    end
%     
% end
% 
% rearrangedC = C;
% 
% if c > 0
% 
% for k = 1: c
% 
% [string, abs, mostAbsReaction] = extinctZn(zn, C, X, k, rm, k)
% 
% % Create rearranged matrix of coef
% rearrangedC(mostAbsReaction, :) = zeros(1, size(C, 2));
% 
% end
% 
% X = transpose(string(:, size(string,2)));
% end
% 
% rearrangedC
% 
% % Create new coef matrix that does not include reactions already perfomed
% Cmod = zeros((nr - c) , size(C, 2));
% 
% for k = 1: nr-c
% 
% % Cmod(k,:) = C();
% 
% end
% 
% 
% for k = 1: size(rm, 2)
%    
%     Srm(1,k) = sum(rm(:, k));
%     
% end
% 
% % finds which element gets extinct faster
% [mostAbs, mostAbsInd] = min(Srm)
% 
% 
% % finds which reaction is responsible for elements extiction
% [a, mostAbsReaction] = min(rm(:,mostAbsInd))
% 
% Cmod = C(mostAbsReaction, :);
% 
% [string, abs] = findAbsState( Cmod, X, k )
% 
% 
% 
% 
% 
% % ------------ For remaining columns (when there are positive entries)
% % % Define sum matrix
% % for k = 1: size(rm, 2)
% %    
% %     Srm(1,k) = sum(rm(:, k));
% %     
% % end
% % 
% % % finds which element gets extinct faster
% % [mostAbs, mostAbsInd] = min(Srm)
% % 
% % 
% % % finds which reaction is responsible for elements extiction
% % [a, mostAbsReaction] = min(rm(:,mostAbsInd))
% % 
% % 
% % X = [9 10];
% % 
% % ne = length(X);
% % 
% % k = [1];
% % 
% % % change coefficient array to contain only one reaction:
% % C = C(mostAbsReaction, :);
% % 
% % [string, abs] = findAbsState( C, X, k )
% % 
% % 
% % % Only one element left, so find which reaction gets element exctict faster
% % rm = [0;-1];
% % 
% % % finds which reaction is more responsible for elements extiction
% % [a, mostAbsReaction] = min(rm)
% % 
% % % k = zeros(ne,1)
% % % 
% % % k(mostAbsReaction,1) = 1
% % k = [1];
% % 
% % X = transpose(string(:, size(string,2)));
% % 
% % C = [1 0 1 1; 2 3 1 0];
% % 
% % % change coefficient array to contain only one reaction:
% % 
% % C = C(mostAbsReaction, :);
% % 
% % [string, abs] = findAbsState( C, X, k )






 
