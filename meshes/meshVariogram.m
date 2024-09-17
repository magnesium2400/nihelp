function [eb, dists, diffs, x, y, e]  = meshVariogram(verts, faces, data, distMax)
%% MESHVARIOGRAM Calculates and plots variogram of a map on a triangular mesh
%% Examples
% See `meshVariogram_test.m` for examples.  
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


%% Main
% Difference between each pair of points
diffs = (data - data.').^2; 

% Distance between each pair of points
if nargin < 4 || isempty(distMax)
    dists = meshEdgeGeodesicDistances(verts, faces); 
else
    dists = meshEdgeGeodesicDistances(verts, faces, [], [], distMax);
end

% Discretise distance i.e. put into bins
[~,distsEdges,distsBinned] = histcounts(dists); 
[G2, Gid] = findgroups(distsBinned(:));

% Mean and std of `diffs` within each bin
temp = splitapply(@(x) [mean(x), std(x)], diffs(:), G2);
[diffsMean, diffsStd] = deal(nan(max(Gid), 1)); 
diffsMean(idx2mask(nonzeros(Gid))) = temp(logical(Gid),1);
diffsStd(idx2mask(nonzeros(Gid)))  = temp(logical(Gid),2);
clear temp; 

% Plot
x = (distsEdges(2:end) + distsEdges(1:end-1))/2;
y = diffsMean; 
e = diffsStd; 
eb = errorbar(x, y, e);  


end

