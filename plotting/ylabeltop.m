function out = ylabeltop(ax)
if nargin < 1; ax = gca; end
p = get(ax.YLabel, 'Position'); yl = ylim;
set(ax.YLabel, 'HorizontalAlignment', 'right');
set(ax.YLabel, 'Position', [p(1), yl(2), p(3)]);
if nargout > 0; out = ax.YLabel; end
end