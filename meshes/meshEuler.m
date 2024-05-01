function out = meshEuler(faces, nverts)
%% MESHEULER Euler characteristic of a triangulated mesh
%% Examples
%   [v,f] = squareMesh3; meshEuler(f) 
%   [v,f] = sphereMesh; meshEuler(f) 
%   [v,f] = torusMesh; meshEuler(f) 
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


if nargin<2; nverts = max(faces, [], 'all'); end
nfaces = height(faces); 
nedges = height(unique(sort(faces2edgelist(faces),2),'rows')); 
out = nverts - nedges + nfaces; 
end

