function out = bestfit(varargin)
%% BESTFIT plots curve of best fit on current axes, user can input degree

% prelims
ip = inputParser;
addOptional(ip, 'degree', 1); 
addParameter(ip, 'doLegend', false);
addParameter(ip, 'doPlot', true);
addParameter(ip, 'axes', gca);
parse(ip, varargin{:});

% get data and fit
obj = findobj(ip.Results.axes, 'Type', 'Scatter');
xpoints = obj.XData;
ypoints = obj.YData;
out = polyfit(xpoints, ypoints, ip.Results.degree);

% plot curve and legend
if ip.Results.doPlot
	hold on;
    plot(sort(xpoints), polyval(out,sort(xpoints)));
end

if ip.Results.doLegend
    legend(string(vpa(poly2sym(out), 4)), 'Location', 'SouthEast');
end

end