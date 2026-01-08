function im = imagescfc(varargin)
[ax, args, nargs] = axescheck(varargin{:});
if isempty(ax); ax = gca(); end

fcMatrix = args{1}; 
if nargs < 2; colorbarFlag = true; 
else; colorbarFlag = args{2}; end


if any(abs(fcMatrix) > 1, 'all'); warning('FC matrix has large values'); end
im = imagesc(ax, fcMatrix, args{3:end});
axis(ax, 'image'); 
clim(ax, [-1, 1]);
colormap(ax, blueblackred); 
if colorbarFlag; colorbar(ax); end
end

