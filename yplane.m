function fs = yplane(y)
%YPLANE Summary of this function goes here
%   Detailed explanation goes here
fs = xyzDrawPlane({@(u,v) u, y, @(u,v) v, [xlim zlim]});
end