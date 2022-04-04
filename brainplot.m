%% plotSurfaceROIBoundary on new figure and adjust camera
function brainplot(verts, faces, rois, data, newFigure, colors)
if nargin < 4
    data = rois;
end
if nargin < 5
    newFigure = true;
end
if nargin < 6
    colors = parula(100);
end

if newFigure; figure; end
plotSurfaceROIBoundary(struct('vertices', verts, 'faces', faces), rois, data, 'faces', colors, 0);

camlight(80,-10); camlight(-80,-10); view([-90 0]); 
axis off; axis tight; axis equal; colorbar;

end