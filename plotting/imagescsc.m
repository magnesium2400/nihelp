function im = imagescsc(scMatrix, colorbarFlag, varargin)
if nargin < 2; colorbarFlag = true; end;
ax = gca; cmap = parula;
im = imagesc(scMatrix, varargin{:});
axis square; colormap(ax, cmap);
caxis(ax, [0 1]);
if colorbarFlag; colorbar('Location', 'southoutside'); end
end

