function [ reactionVectors ] = getReactionVectors( M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Gets number of species in network
l = size(M,2)/2;

% And number of reactions
m = size(M,1);

% Initializes reactionVectors;
% Should have one row for each reaction (m rows)
% and one column for each species (l collumns)
reactionVectors = zeros(m,l);

for i = 1 : m

    for j = 1 : l

        reactionVectors(i,j) = M(i,l+j) - M(i,j)

    end
end



end

