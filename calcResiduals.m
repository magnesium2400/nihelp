function out = calcResiduals(x, y, degree)
%CALCRESIDUALS calculate residuals of y wrt x

if nargin < 3; degree = 1; end

% p = polyfit(x, y, degree);
% yHat = polyval(p,x);
% out = y - yHat;

out = y - polyval(polyfit(x, y, degree), x);

end

