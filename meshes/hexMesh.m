function [verts, faces] = hexMesh(n)
%% HEXMESH Generates equilateral triangle mesh
%% Examples
%   [v,f] = hexMesh;
%   [v,f] = hexMesh(10); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
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

if nargin < 1 || isempty(n); n = 20; end

% generate verts for 1 triangle
[x,y] = meshgrid(1:n, 0:n-1); 
mask = (x+y)<=(n); 

v = reshape( x + (0:height(x)-1)'/2  , [], 1);
v(:,2) = y(:) * sqrt(3)/2; 
v = v(mask,:); 

% rotate 5 times (multiply by transpose of rotation matrix)
nv = arrayfun(@(t) v*[cos(t) sin(t); -sin(t) cos(t)], pi*(1:5)'/3, 'uni', 0);
verts = [0 0; v; cell2mat(nv)];
faces = delaunay(verts(:,1), verts(:,2)); 

end
