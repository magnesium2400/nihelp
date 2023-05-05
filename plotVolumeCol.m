function plotVolumeCol(vol, size, varargin)

if nargin < 2; size = []; end
plotVolume(vol, size, nonzeros(vol), varargin{:}); colorbar;

end




