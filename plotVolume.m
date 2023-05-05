function h = plotVolume(vol, varargin)
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
addRequired(ip, 'vol');
addOptional(ip, 'validationFunction', @logical);

addParameter(ip, 'doValidation', true);
addParameter(ip, 'zeroMidline', false);
addParameter(ip, 'labels', {'x', 'y', 'z'});

addParameter(ip, 's', 20);
addParameter(ip, 'c', []);
addParameter(ip, 'plotOptions', {'filled'});
addParameter(ip, 'ax', gca);

parse(ip, vol, varargin{:});
vol = ip.Results.vol;
validationFunction = ip.Results.validationFunction;
color = ip.Results.c;


%% Plotting
[x,y,z] = ind2sub(size(vol), find(validationFunction(vol)));
xl = [1, size(vol, 1)];
if ip.Results.zeroMidline
    x = x - ceil(size(vol, 1)/2); 
    xl = floor(size(vol, 1)/2) * [-1 1];
end 

if isempty(color) % if user does not specify a color
    if ip.Results.doValidation  % either (i) compute the colors to use; 
        color = vol(validationFunction(vol(:)));
    else                        % or (ii) use the default 
        color = [0 0.4470 0.7410];
    end
end


h = scatter3(ip.Results.ax, x, y, z, ip.Results.s, color, ip.Results.plotOptions{:});

axis equal;

labels = ip.Results.labels;
xlabel(labels{1}); ylabel(labels{2}); zlabel(labels{3});
xlim(xl); ylim([1, size(vol, 2)]); zlim([1, size(vol, 3)]);

end