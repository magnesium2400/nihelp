function [circcentre, circradius] = meshCircumcentre(verts, faces)
%% MESHCIRCUMCENTRE Find the point with the least maximum distance from mesh boundary
%% Examples
%   [v,f] = hexMesh; meshCircumcentre(v,f)
%   [v,f] = hexMesh; c = meshCircumcentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
%   [v,f] = squareMesh3; m = (v(:,1)<10)|(v(:,2)<5); [v,f] = trimExcludedRois(v,f,m); c = meshCircumcentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
% 
% 
%% TODO
% * docs
% * consider weighting dists by area at each vertex
% * consider adding radii to output
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


tr = triangulation(faces, verts); 
trb = tr.freeBoundary; 

d = meshEdgeGeodesicDistances(verts, faces, [], unique(trb)); 
d = sort(d,2,'descend'); % sort each row
[d,id] = sortrows(d, 'ascend'); % get the row with the min val in the first column

circcentre = id(1); 
circradius = d(1); 

end
