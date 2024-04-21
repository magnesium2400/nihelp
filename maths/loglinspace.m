function out = loglinspace(a,b,p,q)
%% LOGLINSPACE Generate mixed logarithmically and linearly spaced vector
%% Examples
%   loglinspace(1,1000,4)
%   loglinspace(1,1000,4,10)
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


if nargin < 4 || isempty(q); q = p; end

x = logspace(log10(a), log10(b), p);
y = arrayfun(@(idx) linspace(x(idx), x(idx+1), q), 1:(p-1), 'Uni', 0);
out = [cell2mat(cellfun(@(a) a(1:(end-1)), y, 'Uni', 0)), b];


end