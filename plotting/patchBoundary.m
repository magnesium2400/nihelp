function [p,b] = patchBoundary(verts, faces, data, varargin)
%% Plot patch of (triangular) boundary of tetrahedral surface
%% Examples
%   v = rand(100,3); f = delaunay(v); figure; patchBoundary(v,f);  
%   v = rand(100,3); f = delaunay(v); figure; scatter3(v(:,1),v(:,2),v(:,3)); hold on; patchBoundary(v,f,v(:,3),'EdgeColor','interp','FaceColor','none');  
%   [v,f] = solidTorusMesh; figure; scat3(v); hold on; patchBoundary(v,f,v(:,3),'FaceAlpha',0.5);  
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

assert(size(faces,2) == 4); % tetrahedal mesh as input
if nargin < 3 || isempty(data); data = {'FaceColor', 'none'}; 
else; data = {'FaceVertexCData', data, 'FaceColor', 'interp'}; end

b = freeBoundary(triangulation(faces, verts));

p = patch('Vertices', verts, 'Faces', b, data{:}, varargin{:}); 


end