function h = plotVolume(V, varargin)
% Documentation
%   This function visualizes a 3D volume represented by a 3D matrix V.
%   It uses scatter3 to plot points in 3D space based on the values in V.
%   The points are colored according to their values, and various options
%   allow customization of the plot.
%
%   Syntax
%   ---
%   h = plotVolume(V)
%   h = plotVolume(V, 'Name', Value)
%
%   Description
%   ---
%   The plotVolume function takes a 3D matrix V and generates a 3D scatter plot
%   of the non-zero elements, with options for validation, coloring, and axis labels.
%
%   Examples
%   ---
%   % Example 1: Basic usage
%   V = rand(10, 10, 10);
%   h = plotVolume(V);
%
%   % Example 2: Using custom validation function
%   h = plotVolume(V, 'validationFunction', @(x) x > 0.5);
%
%   Input Arguments
%   ---
%   V : 3D matrix
%       The volume data to be visualized.
%
%   Name-Value Arguments
%   ---
%   'validationFunction' : function handle or numeric
%       A function to validate which elements of V to plot. If numeric, it
%       can specify a threshold or quantile.
%   'rois' : numeric array
%       Regions of interest to filter the volume data.
%   'doValidation' : logical
%       Whether to apply the validation function (default: true).
%   'zeroMidline' : logical
%       If true, shifts the x-coordinates to center around zero (default: false).
%   'labels' : cell array of strings
%       Labels for the x, y, and z axes (default: {'x', 'y', 'z'}).
%   's' : numeric
%       Size of the scatter points (default: [] uses default size).
%   'c' : numeric or color specification
%       Color of the scatter points (default: [] uses default color).
%   'plotOptions' : cell array
%       Additional options for scatter3 (default: {'filled'}).
%   'Parent' : axes handle
%       The axes in which to plot (default: current axes).
%
%   Output Arguments
%   ---
%   h : handle
%       Handle to the scatter plot object.
%
%   See also
%   ---
%   scatter3, inputParser
%
%   Authors
%   ---
%   Mehul Gajwani, Monash University, 2023
%% Prelims
ip = inputParser;
addRequired(ip, 'V');

addOptional(ip, 'validationFunction', @(x) logical(nan2zero(x)), @(x) isa(x, 'function_handle') || isnumeric(x));
% Consider using @(x) x~=0 & ~isnan(x) also/instead
addParameter(ip, 'rois', [], @isnumeric);

addParameter(ip, 'doValidation', true);
addParameter(ip, 'zeroMidline', false);
addParameter(ip, 'labels', {'x', 'y', 'z'});

addParameter(ip, 's', []);
addParameter(ip, 'c', []);
addParameter(ip, 'plotOptions', {'filled'});
addParameter(ip, 'Parent', gca);

parse(ip, V, varargin{:});
V = ip.Results.V;
rois = ip.Results.rois;
validationFunction = ip.Results.validationFunction;
color = ip.Results.c;
labels = ip.Results.labels;


%% Other options for validationFunction
if ~isempty(ip.Results.rois)
    V = V.*(+ismember(V, rois));
end

if isnumeric(validationFunction)
    if validationFunction >= 1  
        validationFunction = @(x) x > validationFunction;
    else 
        validationFunction = @(x) x > quantile(V(:), validationFunction);
    end
end


%% Plotting
[x,y,z] = ind2sub(size(V), find(validationFunction(V)));
xl = [1, size(V, 1)];
if ip.Results.zeroMidline
    x = x - ceil(size(V, 1)/2); 
    xl = floor(size(V, 1)/2) * [-1 1];
end 

if isempty(color) % if user does not specify a color
    if ip.Results.doValidation  % either (i) compute the colors to use; 
        color = V(validationFunction(V(:)));
    else                        % or (ii) use the default 
        color = lines(1);
    end
end

h = scatter3(ip.Results.Parent, x, y, z, ip.Results.s, color, ip.Results.plotOptions{:});

axis equal tight;

xlabel(labels{1}); ylabel(labels{2}); zlabel(labels{3});
if xl(1) ~= xl(2); xlim(xl); end
if size(V, 2) ~= 1; ylim([1, size(V, 2)]); end 
if size(V, 3) ~= 1; zlim([1, size(V, 3)]); end 

end
