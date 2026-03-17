function out = indexdim(mat, dim) 
%% INDEXDIM Gets the position of the entries in mat in the specified dim
%% Examples
%   a = indexdim(magic(5), 1)
%   a = indexdim(magic(5), 2)
%   
%   

if nargin<2||isempty(dim); dim=1; end
vecs = arrayfun(@(x) 1:x, size(mat), 'Uni', 0); 
out = ndgridn(dim, vecs{:});
end
