function [ rm, zn ] = getReactionMat( C )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Define number of elements and of reactions of network
ne = size(C, 2)/2;
nr = size(C, 1);

% Define reaction matrix
rm = zeros(nr, ne);

% Define matrix to hold indexes of columns with non positive values
zn = zeros(ne, 1); 

for k = 1: ne
    
   % This variable checks if column is of non-negative numbers or not
    bol = 1;
    for i = 1:nr
       
        rm(i,k) = C(i,k + ne) - C(i, k);
        
        if rm(i,k) > 0
            bol = 0;
        end
    end
    
    if bol == 1
      
        zn(k, 1) = 1;
        
    end
    
end

end

