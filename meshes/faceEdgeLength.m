function [out, idx] = faceEdgeLength(verts, faces)
%% FACEEDGELENGTH Calculates the length of each edge on each face in a mesh
%% Examples
%   [v,f] = sphereMesh; l = faceEdgeLength(v,f); 
%   [v,f] = sphereMesh; l = faceEdgeLength(v,f); figure; patchvfc(v,f,max(l,[],2),'EdgeColor','k');  
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


idx = permute(nchoosek(1:width(faces),2), [3 2 1]);
g = reshape(faces(:, idx), height(faces), 2, []);
vg = reshape(verts(g, :), [size(g), width(verts)]);
vgd = squeeze(diff(vg, 1, 2));
out = vecnorm(vgd, 2, 3);

end
