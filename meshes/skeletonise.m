function [verts2, faces2] = skeletonise(verts, faces, rois)
[verts, faces, rois] = checkVertsFacesRoisData(verts, faces, rois);
[verts, faces, rois] = trimExcludedRois(verts, faces, rois);
verts2 = parcellateData(verts, rois);
faces2 = adjacency2triangulation(triangulation2adjacency(faces, rois));
end