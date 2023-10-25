function fs = xyzDrawPlane(xyzInput, varargin)
%XYZDRAWPLANE Helper - not supposed to be directly accessed
fs = fsurf(xyzInput{:}, 'ShowContours', 'off', 'MeshDensity', 3, ...
    'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', [0.5 0.5 0.5], varargin{:});
end

