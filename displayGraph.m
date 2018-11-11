function [ ] = displayGraph( reactionArray, init, a, i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% ---------------- PLOT GRAPH

% First get nu,ber of elements present:

ne = length(init);

 % Displays remaining number of molecules for each element, as a function
 % of time
 figure(i);
 for k = 1: ne
   
     ts = timeseries(reactionArray(k,:),1:size(reactionArray, 2));
     ts = ts.setinterpmethod('zoh');
     plot(ts, '.', 'MarkerSize', 20);
     grid on;
     grid minor;
     hold on;
     
 end
 
 % -------------------- DISPLAY LEGEND 
 
 % Legend for the elements present in the reactions
 legendForGraph = ['A' 'B' 'C' 'D' 'E' 'F'];
 
 % Each color will correspond to an element. Colors will be indicated in
 % graph
 legend(legendForGraph(1),legendForGraph(2), legendForGraph(3), legendForGraph(4), legendForGraph(5), legendForGraph(6));

 % ---------------- DISPLAY ABS STATE
 
 % Displays resulting abs state (if any) as a separate legend in middle of
 % graph
 % This displays the amount of molecules of each element present in the
 % absorbing state, and displays nothing if there's no abs state
 
 % Dimensions of legend
dim = [.3 .2 .8 .3];

% Checks if there is absorbing state or not
bol = 0;
for i = 1: length(a)
    
   if a(i) ~= 0
       bol = 1;
   end
end
a

% Displays legend according to number of elements there are (only displays 
% if there exists abs state.
if bol == 1
    
if ne == 2
    
str = [['Absorbing State: A = ',num2str(a(1))], ...
    [' B = ', num2str(a(2))] ];

annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

if ne == 3
    
str = [['Absorbing State: A = ',num2str(a(1))], [' B = ',...
    num2str(a(2))], [' C = ', num2str(a(3))] ];

annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

if ne == 4
    
str = [['Absorbing State: A = ',num2str(a(1))], [' B = ',...
    num2str(a(2))], [' C = ', num2str(a(3))], [' D = ', num2str(a(4))] ];

annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

if ne == 5

str = [['Absorbing State: A = ',num2str(a(1))], [' B = ',...
    num2str(a(2))], [' C = ', num2str(a(3))], [' D = ', num2str(a(4))],...
    [' E = ', num2str(a(5))] ];
    
annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

if ne == 6

str = [['Absorbing State: A = ',num2str(a(1))], [' B = ',...
    num2str(a(2))], [' C = ', num2str(a(3))], [' D = ', num2str(a(4))],...
    [' E = ', num2str(a(5))], [' F = ', num2str(a(6))] ];
    
annotation('textbox',dim,'String',str,'FitBoxToText','on');
end

end

% ---------------- ADD TITLE

title('Number of Remaining Molecules of each Element vs Time');

hold off;


end

