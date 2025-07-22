function out = closeMeshRegion(verts, faces, rois, tgt, n)

tmp = dilateMeshRegion(verts, faces, rois, tgt, n); 

if length(unique(tmp)) ~= length(unique(rois))
    warning('Dilation of region %i has removed other regions', tgt); 
end

out = erodeMeshRegion(verts, faces, tmp, tgt, n); 
% any vertices NOW not in the region should be their original value
out(out~=tgt) = rois(out~=tgt); 

% everything that WAS in the region should still be in the region
assert(all( out(rois==tgt) == tgt ))
% everything NOW outside the region should have been outside originally
assert(all( rois(out~=tgt) ~= tgt ))



end
