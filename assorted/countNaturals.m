function out = countNaturals(x)
%% COUNTNATURALS Count occurences of natural numbers (positive integers) 
%% Examples
%   N = countNaturals(1:5)
%   N = countNaturals(-1:5)
%   N = countNaturals(magic(2))
%   N = countNaturals(magic(2).^2)
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

assert(all(x == round(x), 'all'), 'Data are not whole numbered');
out = histcounts( x , (0:max(x, [], 'all'))+0.5 );
end