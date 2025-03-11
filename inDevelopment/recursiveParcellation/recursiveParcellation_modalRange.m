function out = recursiveParcellation_modalRange(split, params, mask)

if nargin < 3 || isempty(mask)
    mask = true(height(params.verts), 1); 
else
    mask = logical(mask); 
end

[verts, faces, ~, ~] = ...
    trimExcludedRois(params.verts, params.faces, mask, 'removeUnconnected', false); 

assert(height(verts)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 2);

thr = linspace(min(s.evecs(:,2)), max(s.evecs(:,2)), split+1); 

[~,~,bin] = histcounts(s.evecs(:,2), thr);
OUT = bin;      % correct for off-by-one error at the end
out = OUT;

out = out - 1;
% [v,f] = trimExcludedRois(params.verts, params.faces, mask); 
out = fixDanglingVertices(verts, faces, out); 


end

