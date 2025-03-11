function out = recursiveParcellation_equalAreaPCA(split, params, mask)

if nargin < 3 || isempty(mask)
    mask = true(height(params.verts), 1); 
else
    mask = logical(mask); 
end

[verts, faces, ~, mask] = ...
    trimExcludedRois(params.verts, params.faces, mask, 'removeUnconnected', false); 

% [~, scores] = pca(verts, 'NumComponents', 1);
[~, scores] = pca(params.sphere(mask,:), 'NumComponents', 1);

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

% getIdx = @(x) argout(@() histcounts(scores, x), 3);
% getRowsContaining = @(mat, tgt) mat(any(ismember(mat,tgt),2),:);
% isConn = @(mask) nnz(mask) == height(trimExcludedRois(sphere, faces, mask));
% allConn = @(rois) all(arrayfun( @(ii) isConn(rois==ii) , unique(rois) ));
% nextThr = @(x) min(scoresOrdered(scoresOrdered>x)); 
% prevThr = @(x) max(scoresOrdered(scoresOrdered<x)); 
% 
% if allConn(out)
    out = out - 1;
%     return;
% end

[v,f] = trimExcludedRois(params.verts, params.faces, mask); 
out = fixDanglingVertices(v, f, out); 





end

