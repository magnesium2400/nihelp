function fs = zplane(z, varargin)
%YPLANE Summary of this function goes here
%   Detailed explanation goes here
fs = xyzDrawPlane({@(u,v) u, @(u,v) v, z, [xlim ylim]}, varargin{:});
end