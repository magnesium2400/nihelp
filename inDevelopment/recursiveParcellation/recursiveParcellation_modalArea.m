function out = recursiveParcellation_modalArea(split, params, mask)

if nargin < 3 || isempty(mask)
    mask = true(height(params.verts), 1); 
else
    mask = logical(mask); 
end

[verts, faces, ~, ~] = ...
    trimExcludedRois(params.verts, params.faces, mask, 'removeUnconnected', false); 
assert(height(verts)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 2); 

scores = s.evecs(:,2); 

[scoresOrdered,idx] = sort(scores, 'ascend');

vertAreas = params.vertAreas(mask); 
% vertAreas = faces2verts(faces, calcFaceArea(verts, faces));
areasOrdered = cumsum(vertAreas(idx));


THR = interp1(areasOrdered, scoresOrdered, ...
    areasOrdered(end) * (1:split-1)/split);
THR = [scoresOrdered(1), THR, scoresOrdered(end)];
thr = THR;


[~,~,bin] = histcounts(scores, thr);
OUT = bin;      % correct for off-by-one error at the end
out = OUT;

out = out - 1;
[v,f] = trimExcludedRois(params.verts, params.faces, mask); 
out = fixDanglingVertices(verts, faces, out); 


end

