function [X,u] = denumber(X, setOrder, ignoreZero)
%% DENUMBER Simplify data to integers from 1 to length(unique(X))
%% Examples
%   denumber([1 2 4])
%   denumber([1 4 2])
%   denumber([1 4 2], 'sorted')
%   denumber([1 4 2], 'stable')
%   denumber([1 4 0], [], false)
%   denumber([1 4 0], [], true)
%   denumber([1 -4 0], [], false)
%   denumber([1 -4 0], [], true)
%   
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
if nargin < 3 || isempty(ignoreZero); ignoreZero = false; end
if ignoreZero; mask = logical(X); else; mask = true(size(X)); end
[u,~,ic] = unique(X(mask), setOrder); 
X(mask) = ic; 
% out = reshape(ic, size(X)); 
end
