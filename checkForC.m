function [ extraCon, extraSub, temp_b ] = checkForC( range, r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


n = size(r,1)
% Run code for direct comparisson

extraCon = zeros(1,n);
extraSub = zeros(1,n);
  
range = 10;
% Creates all possible n-tuples with values in range:{-range, -range + 1, ... 0, 1, ...range}
possibleComb = combnk((1:range), n); 

% Now takes all permutations within possibleComb to get:
allPossibleComb = [];

for i = 1: size(possibleComb,1)
   
    temp = perms(possibleComb(i,:));
    
    allPossibleComb = [allPossibleComb; temp];
    
end

allPossibleComb = [allPossibleComb; possibleComb];
   
for i = 1: range
   temp = ones(1,n); 
   temp = temp * i;
   allPossibleComb = [allPossibleComb; temp]; 
   
end

for i = 1 : size(allPossibleComb, 1)
    
    allPossibleComb(i,:)
    temp = allPossibleComb(i,:) * r;
        
        % Check for Subconservation
        if all(temp <=0)
           temp_b = 1;
           extraSub = allPossibleComb(i,:);
           break
        end
        
        % Check for Conservation
        if all(temp ==0)
           temp_b = 2;
           extraCon = allPossibleComb(i,:);
           break
        end
        
        
    end


end

