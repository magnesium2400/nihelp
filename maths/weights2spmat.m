function [w, sa] = weights2spmat(w, n)

if isempty(w); w = speye(n); warning('No weights provided, assuming area at each vertex is 1'); 
elseif isvector(w); w = sparse(1:length(w), 1:length(w), w);
elseif ~ismatrix(w); error('Weights must be vector or matrix'); 
else; w = sparse(w); 
end

if nargin>1 && ~isempty(n)
    assert(length(w)==n, 'weights must be of size n')
end

sa = full(sum(w, 'all')); 

end
