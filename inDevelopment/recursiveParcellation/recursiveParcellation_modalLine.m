function out = recursiveParcellation_modalLine(split, params, mask)

assert(split == 2, 'split must be 2 when using modal line parcellation. Consider using modal range.'); 
if nargin < 3 || isempty(mask)
    mask = true(height(params.vertices), 1); 
else
    mask = logical(mask); 
end

[vertices, faces, ~, ~] = ...
    trimExcludedRois(params.vertices, params.faces, mask, 'removeUnconnected', false); 

assert(height(vertices)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', vertices, 'faces', faces), 2); 
out = +(s.evecs(:,2)>0); 

out = fixDanglingVertices(vertices, faces, out, 5); 

end

