function out = imagescmg(varargin)
out = imagesc(varargin{:});
colorbar; axis square; 
sz = size(out.CData);
if sz(1) == sz(2) && mod(sz(1),2) == 0
hold on; xline(sz(2)/2+0.5); yline(sz(1)/2+0.5);
end
if nargout == 0; clear out; end
end
