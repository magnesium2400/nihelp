function [v,f] = ballMesh(a,b,c)
%% BALLMESH Generate faces and vertices of volumetric ball mesh
%% Examples
%   [v,f] = ballMesh; 
%   [v,f] = ballMesh(3,4,5); figure; tetramesh(f,v); axis equal;   
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

f = @floor;
[x,y,z] = ndgrid(-f(a):f(a), -f(b):f(b), -f(c):f(c)); 
v = [x(:), y(:), z(:)];
m = vecnorm(v./[a,b,c],2,2)<=1; 
v = v(m,:); 
if nargout < 2; return; end

f = delaunay(v);

end

