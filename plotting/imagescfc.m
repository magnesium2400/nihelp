function im = imagescfc(fcMatrix, colorbarFlag, varargin)
if nargin < 2; colorbarFlag = true; end
if any(abs(fcMatrix) > 1, 'all'); warning('FC matrix has large values'); end
im = imagesc(fcMatrix, varargin{:});
axis image; 
clim([-1, 1]);
colormap(gca, bluewhitered_mg); 
if colorbarFlag; colorbar; end
end

