function cb = cbarLegend(ax, labels)
%% Examples
%   figure; scatter(1:10,1:10,[],kron((1:5)', [1;1])); colormap(cool(5)); cbarLegend; 
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


if nargin < 1 || isempty(ax); ax = gca; end

n = size(colormap(ax),1); 
clims = caxis(ax); %#ok<CAXIS>

if clims(2)-clims(1) ~= n-1; warning('caxis and cmap should have same range'); end

if nargin < 2 || isempty(labels); labels = arrayfun(@string, 1:n, 'uni', 0); end

cb = colorbar(ax); 
cb.Ticks = clims(1) + (n-1)/(2*n) + (0:n-1)*(n-1)/n; 
cb.TickLabels = labels; 

end
