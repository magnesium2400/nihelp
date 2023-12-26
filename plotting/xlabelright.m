function out = xlabelright(ax)
%% XLABELRIGHT Shifts axis xlabel (already generated) to the right 
if nargin < 1; ax = gca; end
p = get(ax.XLabel, 'Position'); xl = xlim;
set(ax.XLabel, 'HorizontalAlignment', 'right');
set(ax.XLabel, 'Position', [xl(2), p(2), p(3)]);
if nargout > 0; out = ax.XLabel; end
end