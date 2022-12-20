function out = calcAllRoiMedians(verts, rois)
%% CALCALLROISMEDIAN returns the id of the vertex that is the median of each roi
% Inputs: verts: N*3 matrix of vertex coordinates
%          rois: N*1 vector of roi allocations for each vertex (exclude 0s)
% Outputs:  out: R*1 vector of median ID for each roi

assert(length(verts) == length(rois));
assert(size(verts, 2) == 3);

n = length(verts);
r = max(rois);
out = nan(r, 1);

for ii = 1:r
    currentRoiIdx = find(rois==ii);
    currentMedianIdx = calcRoiMedian(verts(currentRoiIdx, :));
    out(ii) = currentRoiIdx(currentMedianIdx);
end




