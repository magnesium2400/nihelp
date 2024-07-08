function out = denumber(X, setOrder)
%% DENUMBER Simplify data to integers from 1 to length(unique(X))
%% Examples
%   denumber(magic(3)*10)
%   rng(1); a = datasample(10:10:100, 10), denumber(a)
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

if nargin < 2 || isempty(setOrder); setOrder = 'sorted'; end % or 'stable'
[~,~,ic] = unique(X, setOrder); 
out = reshape(ic, size(X)); 
end
