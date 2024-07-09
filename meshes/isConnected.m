function [f,n,g,a] = isConnected(faces, verts)
%% ISCONNECTED 
%% Examples
%   [v,f]  = squareMesh; isConnected(f)
%   [v1,f1]  = squareMesh; v=[v1;v1+[20,0]]; f=[f1;f1+400]; isConnected(f)
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


if nargin > 1 && ~isempty(verts) && ~isscalar(verts); verts = size(verts, 1); 
elseif nargin < 2 || isempty(verts); verts = max(faces(:)); end

if ~isequal(unique(faces(:), 'sorted')', 1:verts); f = false; return; end

a = triangulation2adjacency(faces); 
g = graph(a, 'omitselfloops'); 
n = conncomp(g); 
f = all(n == 1);

end
