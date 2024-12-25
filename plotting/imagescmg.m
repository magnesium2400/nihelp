function out = imagescmg(varargin)
out = imagesc(varargin{:});
colorbar; axis image; 
if nargout == 0; clear out; end
end
