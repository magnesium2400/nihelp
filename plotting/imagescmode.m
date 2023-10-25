function out = imagescmode(varargin)
out = imagesc(varargin{:});
colorbar; axis square; 
sz = size(out.CData);
for ii = 1:ceil(sqrt(max(sz)))
    rectangle('Position', [ [1 1]*(ii-1)^2+0.5, [1 1]*2*ii-1 ]);
end
if nargout == 0; clear out; end
end
