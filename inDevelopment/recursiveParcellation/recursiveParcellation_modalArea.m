function out = recursiveParcellation_modalArea(split, params, mask)

if nargin < 3 || isempty(mask)
    mask = true(height(params.vertices), 1); 
else
    mask = logical(mask); 
end

[vertices, faces, ~, ~] = ...
    trimExcludedRois(params.vertices, params.faces, mask, 'removeUnconnected', false); 
assert(height(vertices)==nnz(mask))
s = calc_geometric_eigenmode(struct('vertices', vertices, 'faces', faces), 2); 
vertexAreas = params.vertexAreas(mask); 

scores = s.evecs(:,2); 
[scoresOrdered,idx] = sort(scores, 'ascend');
areasOrdered = cumsum(vertexAreas(idx));

thr = interp1(areasOrdered, scoresOrdered, areasOrdered(end) * (1:split-1)/split);
thr = [scoresOrdered(1), thr, scoresOrdered(end)];
[~,~,bin] = histcounts(scores, thr);
out = bin - 1;

% [v,f] = trimExcludedRois(params.vertices, params.faces, mask); 
out = fixDanglingVertices(vertices, faces, out, 5); 


end

