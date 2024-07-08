function [centre, dists, weights] = meshFrechet(verts, faces)
%% MESHFRECHET Finds the (approximate) Riemannian centre of mass of mesh
%% Examples
%   [v,f] = hexMesh; c = meshFrechet(v,f); 
%   [v,f] = hexMesh; c = meshFrechet(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
%   [v,f] = hexMesh; v(:,1) = v(:,1) + 10*(v(:,1)>=10); c = meshFrechet(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
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

dists = meshEdgeGeodesicDistances(verts, faces); 
weights = faces2verts(faces, calcFaceArea(verts, faces), size(verts,1)); 
% weights(end+1:length(dists)) = NaN; 

dw = dists.*weights/sum(weights); 
[~,centre] = min(sum(dw)); 

end
