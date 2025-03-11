function out = recursiveParcellation_modalLine(split, params, mask)

assert(split == 2); 
if nargin < 3 || isempty(mask)
    mask = true(height(params.verts), 1); 
else
    mask = logical(mask); 
end

[verts, faces, ~, ~] = ...
    trimExcludedRois(params.verts, params.faces, mask, 'removeUnconnected', false); 

assert(height(verts)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 2); 
out = +(s.evecs(:,2)>0); 

out = fixDanglingVertices(verts, faces, out); 

end

