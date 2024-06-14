function mask = idx2mask(idx, n)
if nargin < 2 || isempty(n); n = max(idx); end
mask = full(sparse(idx, 1, true, n, 1)); 
end
