function out = openMeshRegion(verts, faces, rois, tgt, n)

tmp = erodeMeshRegion(verts, faces, rois, tgt, n); 

if ~any(tmp==tgt)
    warning('Erosion has removed region %i', tgt); 
end

out = dilateMeshRegion(verts, faces, tmp, tgt, n); 

% any vertices originally not in the region should be their original value
out(rois~=tgt) = rois(rois~=tgt); 

% anything NOW in the region should have been in the region originally
assert(all( rois(out==tgt) == tgt ));

end
