function fs = xyzDrawPlane(xyzInput, varargin)
%XYZDRAWPLANE Summary of this function goes here
%   Detailed explanation goes here
fs = fsurf(xyzInput{:}, 'ShowContours', 'off', 'MeshDensity', 3, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', [0.5 0.5 0.5]);
end

