function [fig_handle, axes_handle, scroll_bar_handles, scroll_func] = ...
    videovolume4(vols, varargin)

redraw_func = @(n) redraw(vols, n); 
[fig_handle, axes_handle, scroll_bar_handles, scroll_func] = videofig(size(vols,4), redraw_func, varargin{:});

    function redraw(vols, n)
        % [xyz,d] = vol2xyz(vol, logical(vol)); 
        % mask = sign(dim)*xyz(:, abs(dim)) >= sign(dim)*n; 
        plotVolume(vols(:,:,:,n)); 
        % colormap needs to be global (i.e. independent of mask)
        z = nonzeros(vols); clim([ min(z) , max(z) + dirac(max(z)-min(z)) ]); 
        axis off;      
    end

end

