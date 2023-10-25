function fs = xplane(x, varargin)
%XPLANE Summary of this function goes here
%   Detailed explanation goes here
fs = xyzDrawPlane({x, @(u,v) u, @(u,v) v, [ylim zlim]}, varargin{:});
end