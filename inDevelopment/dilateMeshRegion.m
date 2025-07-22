function newRois = dilateMeshRegion(verts, faces, rois, regionToDilate, numberOfDilations)

A = triangulation2adjacency(faces); 
m = rois == regionToDilate; 
x = mvmult(A, m, numberOfDilations); 
newRois = rois; 
newRois(logical(x)) = regionToDilate; 

end
