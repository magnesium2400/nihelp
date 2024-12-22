function [incentre, inradius, D] = graphIncentre(g, boundary)
%% GRAPHINCENTRE Find the point with the greatest minimal distance from graph boundary
%% Examples
%   [v,f] = hexMesh; graphIncentre(graph(triangulation2adjacency(f)))
%   [v,f] = hexMesh; g = graph(triangulation2adjacency(f)); c = graphIncentre(g); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
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

if nargin < 2 || isempty(boundary); boundary = 'all'; 
else;                               boundary = unique(boundary); end

D = distances(g, 'all', boundary); 
d = sort(D,2,'ascend'); % sort each row
[d,id] = sortrows(d, 'descend'); % get the row with the max val in the first column
incentre = id(1); 
inradius = d(1); 

end