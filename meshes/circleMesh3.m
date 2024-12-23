function [verts, faces] = circleMesh3(n, seed, zfunc)
%% CIRCLEMESH3 Generates 3 dimensional circular mesh with z a function of x and y
%% Examples
%   v = circleMesh3;
%   v = circleMesh3; figure; scatter3(v(:,1), v(:,2), v(:,3), '.'); 
%   [v,f] = circleMesh3(5);
%   [v,f] = circleMesh3(5); figure; trimesh(f, v(:,1), v(:,2), v(:,3)); 
%   [v,f] = circleMesh3(5,5); figure; trimesh(f, v(:,1), v(:,2), v(:,3)); 
%   [v,f] = circleMesh3(9,[],@(x,y)(x-5).^2-(y-5).^2); figure; trimesh(f, v(:,1), v(:,2), v(:,3)); 
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
if nargin < 3 || isempty(zfunc);zfunc = @(x,y) zeros(size(x)); end

[verts, faces] = circleMesh(n, seed); 
verts(:,3) = zfunc(verts(:, 1), verts(:, 2)); 

end

