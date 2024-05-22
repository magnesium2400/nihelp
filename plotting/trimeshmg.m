function t = trimeshmg(verts, faces, varargin)
%% TRIMESHMG Wrapper to simplify trimesh
%% Examples
%   figure; trimeshmg(eye(3), 1:3); 
%   figure; trimeshmg([0 0 0; eye(3)], [1 2 3; 1 2 4; 1 3 4; 2 3 4]); 
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

if width(verts) == 2
    t = trimesh(faces, verts(:, 1), verts(:, 2), varargin{:}); 
elseif width(verts) == 3
    t = trimesh(faces, verts(:, 1), verts(:, 2), verts(:, 3), varargin{:}); 
end
axis equal tight;
end
