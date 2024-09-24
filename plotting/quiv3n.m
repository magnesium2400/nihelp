function [q,vn] = quiv3n(verts,faces,varargin)
%% QUIV3N Shorthand for quiver3 on vertex normals
%% Examples
%   [v,f]=torusMesh; figure; patchvfc(v,f,'w'); hold on; quiv3n(v,f); 
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


tr = triangulation(faces,verts); 
vn = vertexNormal(tr); 
q = quiver3(verts(:,1),verts(:,2),verts(:,3),vn(:,1),vn(:,2),vn(:,3),varargin{:}); 


end
