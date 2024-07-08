function [fig_handle, axes_handle, scroll_bar_handles, scroll_func] = ...
    videovolume(vol, dim, varargin)

if nargin < 2 || isempty(dim); dim = +1; end

sz = size(vol, abs(dim)); 
redraw_func = @(n) redraw(vol, n, dim); 
[fig_handle, axes_handle, scroll_bar_handles, scroll_func] = videofig(sz, redraw_func, varargin{:});
if dim < 0; scroll_func(sz); end

    function redraw(vol, n, dim)
        [xyz,d] = vol2xyz(vol, logical(vol)); 
        mask = sign(dim)*xyz(:, abs(dim)) >= sign(dim)*n; 
        plotVolume(xyz2vol(xyz(mask,:), d(mask), 0, size(vol))); 
        % clims needs to be global (i.e. independent of mask)
        z = nonzeros(d); clim([ min(z) , max(z) + dirac(max(z)-min(z)) ]); 
        axis off;      
    end

end

