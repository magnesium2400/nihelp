function [faces, verts, vol] = volumeSurface(V)
% Note that this returns the coordinates of the vertices in voxel space
% To translate voxels to native space, use affineVerts

verts = vol2xyz(V, logical(V)); 
as = alphaShape(verts); 
tr = triangulation(as.alphaTriangulation, verts);

if nargout == 1
    faces = tr.freeBoundary; 
else 
    [faces, verts] = tr.freeBoundary; 
    vol = xyz2vol(verts, [], 0, size(V)); 
end


end
