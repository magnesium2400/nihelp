function [f,c] = volumetric2surface(v, alphaRadius)
% alpha shape
c = alphaShape(v);
if nargin > 1 && ~isempty(alphaRadius); c.Alpha = alphaRadius; end
d = c.alphaTriangulation;

% get surface of alpha shape
e = triangulation(d, c.Points);
f = freeBoundary(e);
end