function out = imagescmg(varargin)
out = imagesc(varargin{:});
if nargout == 0; clear out; end
colorbar; axis square; 
end
