function out = imagescmg(varargin)
out = imagesc(varargin{:});
colorbar; axis square; 
if nargout == 0; clear out; end
end
