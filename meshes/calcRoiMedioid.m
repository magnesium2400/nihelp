function out = calcRoiMedioid(verts)
%% CALCROIMEDIAN returns the id of the point in the pointcloud closest to the mean
% Verts: N * 3 matrix of vector coordinates
% out:   index of which position in the list the vertex closest to the mean
% is

assert(size(verts, 2) == 3);

[~,out] = pdist2(verts, mean(verts), 'Euclidean', 'Smallest', 1);