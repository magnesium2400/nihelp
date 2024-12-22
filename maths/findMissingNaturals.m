function out = findMissingNaturals(v, nmax)
%% FINDMISSINGNATURALS Finds the naturals numbers missing from a list
%% Examples
%   findMissingNaturals(2:2:10)
%   findMissingNaturals(2:2:10, 12)
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

if nargin < 2; nmax = max(v); end
x = 1:nmax; 
out = x(~ismember(x,unique(v)));

end