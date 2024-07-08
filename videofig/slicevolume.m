function [fig_handle, axes_handle, scroll_bar_handles, scroll_func] = ...
    slicevolume(vol, dim, varargin)

if nargin < 2 || isempty(dim); dim = +1; end

sz = size(vol, abs(dim)); 
redraw_func = @(n) redraw(vol, n, dim); 
[fig_handle, axes_handle, scroll_bar_handles, scroll_func] = videofig(sz, redraw_func, varargin{:});
if dim < 0; scroll_func(sz); end

    function redraw(vol, n, dim)
        sl = sliceDim(vol, abs(dim), n);
        switch dim
            case {-1, 2,-3}; rotFcn = @(x) rot90(x); 
            case { 1,-2, 3}; rotFcn = @(x) fliplr(rot90(x)); 
        end
        imagesc(rotFcn(sl)); 
        z = vol(:); clim([ min(z) , max(z) + dirac(max(z)-min(z)) ]); 
        axis equal tight off;      
    end

end

