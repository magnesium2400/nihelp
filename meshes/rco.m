function [verts, faces] = rco(flag)
%% RCO Generates surface mesh of (pseudo)rhombicuboctahedron
%% Examples
%   [v,f] = rco; figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; 
%   [v,f] = rco('pseudo'); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; 
%   [v,f] = rco; [v,f] = augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; 
%   [v,f] = rco('pseudo'); [v,f] = augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; 
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

faces = [1 2 3; 1 3 4; 1 6 2; 2 6 7; 2 7 8; 2 8 3; 3 8 9; 3 9 10; 3 10 4; 10 11 4; 4 11 12; 4 12 1; 1 12 5; 1 5 6; ...
    6 14 7; 7 14 15; 7 15 8; 8 15 16; 9 8 16; 9 16 17; 9 17 10; 10 17 18; 10 18 11; 11 18 19; 11 19 12; 12 19 20; 12 20 5; 5 20 13; 5 13 6; 6 13 14; ...
    13 21 14; 14 21 15; 15 21 22; 15 22 16; 16 22 17; 17 22 23; 17 23 18; 18 23 19; 19 23 24; 19 24 20; 20 24 21; 13 20 21; 21 24 22; 24 23 22];

s = 1 + sqrt(2);
verts = [1 1 s; -1 1 s; -1 -1 s; 1 -1 s; s 1 1; 1 s 1; -1 s 1; -s 1 1; -s -1 1; -1 -s 1; 1 -s 1; s -1 1]/2;

if nargin >= 1 && strcmp(flag, 'pseudo') % rotate lower copula
    t = 1/sqrt(2); 
    verts = [verts; verts([5:12,1:4],:)*[t t 0; -t t 0; 0 0 -1]];
else % duplicate vertices with z-coordinate negated
    verts = [verts; verts([5:12,1:4],:)*[1 0 0;  0 1 0; 0 0 -1]];
end

end
