function mask = idx2mask(idx, n)
%% IDX2MASK Converts indices to logical mask
%% Examples
%   a = [1 2 5 9]; b = idx2mask(a); 
%   a = [1 2 5 9]; b = idx2mask(a, 10); 
%   rng(1); a=rand(99,1)>0.5; b=find(a); c=idx2mask(b,99); assert(isequal(a,c));   
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


if nargin < 2 || isempty(n); n = max(idx); end
mask = full(sparse(idx, 1, true, n, 1)); 
end
