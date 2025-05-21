function h = heat3(X,Y, varargin)
%% HEAT3 Heatmap and scatterplot using hist3
%% Examples
%   figure; heat3(randn(10000,1), randn(10000,1));
%   figure; heat3(randn(1000000,1), randn(1000000,1), 'Nbins', [100 100]); colormap(flip(autumn)); colorbar;   
%   figure; heat3(rand(1000000,1),  randn(1000000,1), 'Nbins', [100 100]); colormap(flip(autumn)); colorbar;   
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 


%% Prelims
ip = inputParser; 
ip.addRequired('X', @isnumeric); 
ip.addRequired('Y', @isnumeric); 

ip.addParameter('Nbins',    [10 10],    @isnumeric); 
ip.addParameter('Ctrs',     {},         @iscell); 
ip.addParameter('Edges',    {},         @iscell); 

ip.addParameter('histOptions', {'CDataMode', 'auto', 'FaceColor', 'interp', 'EdgeColor', 'none'});

ip.parse(X,Y,varargin{:}); 
X           = ip.Results.X; 
Y           = ip.Results.Y; 
nbins       = ip.Results.Nbins; 
ctrs        = ip.Results.Ctrs; 
edges       = ip.Results.Edges; 
histOptions = ip.Results.histOptions; 


%% Plot
% hist3 has a bug in version <2024a Update 5
if ~isempty(edges)
    hist3([X(:), Y(:)], 'Edges', edges);
elseif ~isempty(ctrs)
    hist3([X(:), Y(:)], 'Ctrs', ctrs);
elseif ~isempty(nbins)
    hist3([X(:), Y(:)], 'Nbins', [nbins(1), nbins(end)]);
else
    error('Specify bins for heat3');
end

h = findobj(gca,'Type','Surface','Tag','hist3');
set(h, histOptions{:}); 

view(0, 90); 
set(gca, 'ZScale', 'log'); % hides 0 too


end
