function out = countNaturals(x, nmax)
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
if nargin < 2 || isempty(nmax); nmax = max(x, [], 'all'); end
assert(all(x == round(x), 'all'), 'Data are not whole numbered');
out = histcounts( x , (0:nmax)+0.5 );
end

