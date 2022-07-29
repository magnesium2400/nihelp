function brainplot(verts, faces, rois, data, newFigure, colors, colorLabel)
%% BRAINPLOT plotSurfaceROIBoundary on new figure and adjust camera

if nargin < 4
    data = rois;
end
if nargin < 5
    newFigure = true;
end
if nargin < 6
    colors = plasma(100);
end

if newFigure; figure; end

plotSurfaceROIBoundary(struct('vertices', verts, 'faces', faces), rois, data, 'faces', colors, 0, 1.5);
camlight(80,-10); camlight(-80,-10); view([-90 0]); 
axis off; axis tight; axis equal; c = colorbar; 

if nargin >= 7
    c.Label.String = colorLabel;
    c.Label.FontSize = 12;
end 

end