function out = xlabelleft(ax)
%% XLABELLEFT Shifts axis xlabel (already generated) to the left 
%% ENDPUBLISH
if nargin < 1; ax = gca; end
p = get(ax.XLabel, 'Position'); xl = xlim;
set(ax.XLabel, 'HorizontalAlignment', 'left');
% set(ax.XLabel, 'Position', [xl(1), p(2), p(3)]);
if nargout > 0; out = ax.XLabel; end
end