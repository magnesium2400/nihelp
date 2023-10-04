function im = imagescfc(fcMatrix, colorbarFlag, varargin)
if nargin < 2; colorbarFlag = true; end;
% cmap = multi_cmap(-0.5, 'darkblue', 0.25, 'orangered', 1, 'darkCentre', 1, 'firstCut', {0 50}, 'secondCut', {0 10});
cmap = bluewhitered_mg(100, 'colors', [0 0 1; 0 0 0.5; 0 0 0 ; 1 0 0 ; 1 1 0], 'clims', [-0.5 1]);
ax = gca; 
im = imagesc(fcMatrix, varargin{:});
axis square; colormap(ax, cmap);
clim(ax, [-0.5 1]);
if colorbarFlag; colorbar('Location', 'southoutside'); end
end

