function r = subtitleCorr(varargin)
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

r = corr(scatterPlot.XData(:), scatterPlot.YData(:), 'type', corrType);

addSubtitle(ax, sprintf("%s correlation = %.4f", corrType, r))

end

function addSubtitle(ax, str)
subt = ax.Subtitle.String;
if isempty(subt); subtitle(ax, str); %#ok<ALIGN> 
elseif iscell(subt); subtitle(ax, [subt(:)', {str}]);
else; subtitle(ax, {subt, str}); end

end