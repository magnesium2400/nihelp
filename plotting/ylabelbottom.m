function out = ylabelbottom(ax)
if nargin < 1; ax = gca; end
p = get(ax.YLabel, 'Position'); yl = ylim;
set(ax.YLabel, 'HorizontalAlignment', 'left');
set(ax.YLabel, 'Position', [p(1), yl(1), p(3)]);
if nargout > 0; out = ax.YLabel; end
end