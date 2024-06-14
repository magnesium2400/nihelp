function [verts2, faces2, mask] = removeUnconnectedVerts(verts, faces)
%% REMOVEUNCONNECTEDVERTS Removes vertices not part of any faces
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


A = triangulation2adjacency(faces, 1:height(verts), 'returnSparse', true);
G = graph(A);
N = conncomp(G); 
mask = N == mode(N); 
[verts2, faces2] = trimExcludedRois(verts, faces, mask, 'removeUnconnected', 1); 
end
