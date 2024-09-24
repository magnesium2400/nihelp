function out = quiv3(verts,quivs,varargin)
%% QUIV3 Shorthand for quiver3
%% Examples
%   [v,f]=torusMesh; vn=vertexNormal(triangulation(f,v)); figure; patchvfc(v,f,'w'); hold on; quiv3(v,vn); 
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

out = quiver3(verts(:,1),verts(:,2),verts(:,3),quivs(:,1),quivs(:,2),quivs(:,3),varargin{:}); 
end
