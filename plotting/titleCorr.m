function r = titleCorr(varargin)
%% 
% inputs: corrtype (string) optional, axis handle (optional)
% adds correlation coefficient of sscatterplot to subtitle
% outputs: correlation coefficient



ip = inputParser;
ip.addOptional('corrType', 'Pearson', @(x) isStringScalar(x) || ischar(x));
ip.addOptional('ax', gca);

ip.parse(varargin{:});
corrType = ip.Results.corrType;
ax = ip.Results.ax;


if isa(ax, 'matlab.graphics.axis.Axes')
    scatterPlot = ax.Children; 
else 
    scatterPlot = ax;
    ax = scatterPlot.Parent;
end
assert(isa(scatterPlot, 'matlab.graphics.chart.primitive.Scatter'));

m = ~isinf(scatterPlot.XData(:)) & ~isinf(scatterPlot.YData(:));

r = corr( ...
    reshape(scatterPlot.XData(m),[],1), ...
    reshape(scatterPlot.YData(m),[],1), ...
    'type', corrType, 'Rows', 'pairwise');

addTitle(ax, sprintf("%s correlation = %.4f", corrType, r))

end

function addTitle(ax, str)
subt = ax.Title.String;
if isempty(subt); title(ax, str); %#ok<ALIGN> 
elseif iscell(subt); title(ax, [subt(:)', {str}]);
else; title(ax, {subt, str}); end

end