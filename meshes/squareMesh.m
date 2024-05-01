function [verts, faces] = squareMesh(n, seed)
%% SQUAREMESH Generates mesh with regular border and regular or irregular fill
%% Examples
%   [v,f] = squareMesh;
%   [v,f] = squareMesh(10,'default'); figure; trimesh(f, v(:,1), v(:,2)); 
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


if nargin < 1 || isempty(n);    n = 20;     end
if nargin < 2 || isempty(seed); seed = -1;  end % regular mesh by default (incorrect seed specified)

try % if seed is specified/is appropriate, generate irregular mesh
    rng(seed);
    t = (1:(n-1)).'; z = ones(size(t)); o = ones(size(t))*n;
    x = [t;o;o-t+1;z]; y = [z;t;o;o-t+1];
    verts = [ x,y ; rand((n-2)^2,2)*(n-1)+1 ];
catch % otherwise (or by default), generate regular mesh
    [x,y] = meshgrid(1:n); 
    verts = [x(:), y(:)];
end

faces = delaunay(verts(:,1),verts(:,2));

end