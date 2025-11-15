function newRois = dilateMeshRegion(verts, faces, rois, regionToDilate, numberOfDilations)

m = rois == regionToDilate;
A = logical(triangulation2adjacency(faces));
for ii = 1:numberOfDilations; m = A*m | m; end
newRois = rois;
newRois(m) = regionToDilate;

end
