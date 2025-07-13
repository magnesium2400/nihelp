function out = slice2image(slice, cmap, clims)
if nargin<3 || isempty(clims); clims = minmax(slice,[],'all'); end
out = reshape(vals2colormap(slice(:), cmap, 'clims', clims), [size(slice), 3]); 
end
