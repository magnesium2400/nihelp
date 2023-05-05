function [h, c] = plotNifti(FILENAME, varargin)
h = plotVolume(niftiread(FILENAME), varargin{:}); c = colorbar;
end
