function [circcentre, circradius, D] = graphCircumcentre(g, boundary)
%% GRAPHCIRCUMCENTRE Find the point with the least maximum distance from graph boundary
%% Examples
%   [v,f] = hexMesh; graphCircumcentre(graph(triangulation2adjacency(f)))
%   [v,f] = hexMesh; g = graph(triangulation2adjacency(f)); c = graphCircumcentre(g); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2)); 
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
d = sort(D,2,'descend'); % sort each row
[d,id] = sortrows(d, 'ascend'); % get the row with the min val in the first column
circcentre = id(1); 
circradius = d(1); 

end