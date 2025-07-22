function [out,idx]  = invsort(X, varargin)
%% INVSORT Find the reverse of a sort order (inverse of permutation vector)
%% Examples
%   invsort([5 1 3 4 2])
%   a = [5 1 3 4 2]; b = invsort(a); c = sort(a); c(b), isequal(ans, a)
%   invsort([50 10 30 40 20])
%   a = [50 10 30 40 20]; b = invsort(a); c = sort(a); c(b), isequal(ans, a)
%   a = magic(3), b = [2 3 1]; c = a(:,b), c(:, invsort(b))
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


[~,idx] = sort(X(:), varargin{:}); 
out(idx) = 1:numel(X); 
out = reshape(out, size(X)); 
end
