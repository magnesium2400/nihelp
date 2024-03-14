function [verts2, faces2] = skeletonise(verts, faces, rois)
%% SKELETONISE Downsample mesh according to parcellation
%% Usage Notes
% Requires NSB_utils_matlab
%
%
%% Examples
%   [x,y] = meshgrid(1:50); z=10*peaks(50)+x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=kron(magic(10), ones(5)); [v2,f2]=skeletonise(v,f,r(:)); figure; patch('Vertices', v2, 'Faces', f2, 'FaceColor', 'none');
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


[verts, faces, rois] = checkVertsFacesRoisData(verts, faces, rois);
[verts, faces, rois] = trimExcludedRois(verts, faces, rois);
verts2 = parcellateData(verts, rois);
faces2 = adjacency2triangulation(triangulation2adjacency(faces, rois));
end