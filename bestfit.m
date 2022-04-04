%% plot line/curve of best fit in current figure, user to input degree
function out = bestfit(degree)

if nargin < 1
    out = bestfit(1);
    return
end

obj = findobj(gcf, 'Type', 'Scatter');
xpoints = obj.XData;
ypoints = obj.YData;

hold on; 
out = polyfit(xpoints, ypoints, degree);
plot(sort(xpoints), polyval(out,sort(xpoints)));

legend(string(vpa(poly2sym(out), 4)), 'Location', 'SouthEast');

end
