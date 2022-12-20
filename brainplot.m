function out = brainplot(verts, faces, rois, data, newFigure, colors, colorLabel)
%% BRAINPLOT plotSurfaceROIBoundary on new figure and adjust camera
% Minimal behaviour requires verts and faces (rois and data preferred)
% Default is to allocate whole brain to one roi and use noise for colouring

% many options for input
if nargin == 1 % if 1 input, assume it is a struct
    if isUnemptyField(verts, 'rois'); brainplot(verts.vertices, verts.faces, verts.rois); return;
    else; brainplot(verts.vertices, verts.faces); return; end
end

if nargin == 2 % if 2 inputs, make 1 large roi and use random data
    rois = ones(length(verts), 1);
    data = rand(length(verts), 1);
elseif nargin == 3 % if 3 inputs, colours rois based on ROI ID
    data = rois;
end

if nargin < 5
    newFigure = true;
end
if nargin < 6
    colors = plasma(100);
end


% plotting
if newFigure; figure; end

out = plotSurfaceROIBoundary(struct('vertices', verts, 'faces', faces), rois, data, 'faces', colors, 0, 1.5);
camlight(80,-10); camlight(-80,-10); view([-90 0]); 
axis off; axis tight; axis equal; c = colorbar; 

if nargin >= 7
    c.Label.String = colorLabel;
    c.Label.FontSize = 12;
end 

end