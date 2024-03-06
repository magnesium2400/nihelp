function out = calcResiduals(x, y, degree)
%% CALCRESIDUALS Calculate residuals of y wrt x
%% Examples
%   x = 1:10; y = x.^2; figure; scatter(x, y); lsline; calcResiduals(x, y)
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if nargin < 3; degree = 1; end

% p = polyfit(x, y, degree);
% yHat = polyval(p,x);
% out = y - yHat;

out = y - polyval(polyfit(x, y, degree), x);

end

