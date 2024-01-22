function h = plotVolume(V, varargin)
%PLOTVOLUME Wrapper for scatter3 to plot a volume
%   Syntax
%   ---
%   
%   
%   
%   Description
%   ---
%   
%   
%   
%   Examples
%   ---
%   
%   
%   
%   Input Arguments
%   ---
%   
%   
%   Name-Value Arguments
%   ---
%   
%   
%   
%   Output Arguments
%   ---
%   
%   
%   See also
%   ---
%   
%   
%   
%   Authors
%   ---
%   Mehul Gajwani, Monash University, 2023

%% Prelims
ip = inputParser;
addRequired(ip, 'V');
addOptional(ip, 'validationFunction', @logical);

addParameter(ip, 'doValidation', true);
addParameter(ip, 'zeroMidline', false);
addParameter(ip, 'labels', {'x', 'y', 'z'});

addParameter(ip, 's', 20);
addParameter(ip, 'c', []);
addParameter(ip, 'plotOptions', {'filled'});
addParameter(ip, 'ax', gca);

parse(ip, V, varargin{:});
V = ip.Results.V;
validationFunction = ip.Results.validationFunction;
color = ip.Results.c;
labels = ip.Results.labels;


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


h = scatter3(ip.Results.ax, x, y, z, ip.Results.s, color, ip.Results.plotOptions{:});

axis equal tight;

xlabel(labels{1}); ylabel(labels{2}); zlabel(labels{3});
if xl(1) ~= xl(2); xlim(xl); end
if size(V, 2) ~= 1; ylim([1, size(V, 2)]); end 
if size(V, 3) ~= 1; zlim([1, size(V, 3)]); end 

end
