function [ string, abs, mostAbsReaction ] = extinctZn( zn, C, X, k, rm, c )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% If any column in rm is composed of only non-positive elements, consider
% elements correspondent to those columns first.

if c > 0
       
       % Treat a as dummy variable, do this to find which reaction gets the
       % specific element extinct faster
       [a, mostAbsReaction] = min(rm(:,find(zn > 0, c)))
       
       % Perfoms reactions associated to specific result above:
       % change coefficient array to contain only one reaction:
        Cmod = C(mostAbsReaction, :);

        [string, abs] = findAbsState( Cmod, X, k );
    
    
end

end

