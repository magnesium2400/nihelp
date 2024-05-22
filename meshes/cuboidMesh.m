function [v,f]=cuboidMesh(a,b,c)
%% CUBOIDMESH Generate faces and vertices of volumetric ball mesh
%% Examples
%   [v,f] = cuboidMesh; 
%   [v,f] = cuboidMesh(3,4,5); figure; tetramesh(f,v);  
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

if nargin < 1 || isempty(a); a = 5; end
if nargin < 2 || isempty(b); b = a;  end
if nargin < 3 || isempty(c); c = (a+b)/2;  end

[x,y,z] = ndgrid(1:a,1:b,1:c); 
v = [x(:), y(:), z(:)];
if nargout < 2; return; end

f = delaunay(v);

end

