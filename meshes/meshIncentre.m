function [incentre, inradius] = meshIncentre(verts, faces)
%% MESHINCENTRE Find the point least close to anywhere on the boundary
%% Examples
%   [v,f] = hexMesh; meshIncentre(v,f)
%   [v,f] = hexMesh; c = meshIncentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
%   [v,f] = squareMesh3; m = (v(:,1)<10)|(v(:,2)<5); [v,f] = trimExcludedRois(v,f,m); c = meshIncentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
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
d = sort(d,2,'ascend'); % sort each row
[d,id] = sortrows(d, 'descend'); % get the row with the max val in the first column

incentre = id(1); 
inradius = d(1); 

end

