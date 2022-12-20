function [out, regressionStats] = bestfit(varargin)
%% BESTFIT plots curve of best fit on current axes, user can input degree

% prelims
ip = inputParser;
addOptional(ip, 'degree', 1); 
addParameter(ip, 'doLegend', false);
addParameter(ip, 'doPlot', true);
addParameter(ip, 'axes', gca);
addParameter(ip, 'zeroIntercept', false);
addParameter(ip, 'plotOptions', {'r', 'LineWidth', 2});
addParameter(ip, 'changeLimits', false);
parse(ip, varargin{:});

% get data
obj = findobj(ip.Results.axes, 'Type', 'Scatter');
xpointsRaw = obj.XData;
ypointsRaw = obj.YData;
invalidPointsRaw = isnan(xpointsRaw) | isnan(ypointsRaw) | isinf(xpointsRaw) | isinf(ypointsRaw);
xpoints = xpointsRaw(~invalidPointsRaw);
ypoints = ypointsRaw(~invalidPointsRaw);

% fit data
% out = polyfit(xpoints, ypoints, ip.Results.degree); % old way
% new way allows for zero intercept to be forced
if ip.Results.zeroIntercept; powers = ip.Results.degree:-1:1; 
else; powers = ip.Results.degree:-1:0; end
x = reshape(xpoints, [], 1) .^ powers; 
[out,~,~,~,regressionStats] = regress(reshape(ypoints, [], 1), x);
if ip.Results.zeroIntercept; out = [out; 0]; end

% plot curve and legend
if ip.Results.doPlot
    xl = xlim; yl = ylim;
	hold(ip.Results.axes, 'on');

    xToPlot = linspace(min(xpoints), max(xpoints), 100);
    plot(xToPlot, polyval(out,xToPlot), ip.Results.plotOptions{:});

    if ~ip.Results.changeLimits; xlim(xl); ylim(yl); end

end

if ip.Results.doLegend
    legend(string(vpa(poly2sym(out), 4)), 'Location', 'SouthEast');
end

end