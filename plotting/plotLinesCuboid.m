function plotLinesCuboid(xyzlims, varargin)
%% Examples
%   figure; plotLinesCuboid([0 0 0; 1 1 1]);
%   figure; plotLinesCuboid(randn(2,3), 'Color', 'k');
%
%


assert(height(xyzlims) == 2 & width(xyzlims) == 3); 

r = @(x) xyzlims(repmat(x, 3, 1)); 
plotLines( r([1 3 5; 2 3 6; 2 4 5; 1 4 6]), ...
    [r([2 3 5]);r([1 3 6]);r([1 4 5]);r([2 4 6])], varargin{:}); 

end






