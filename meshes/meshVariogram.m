function [y, e, x, diffs, dists]  = meshVariogram(verts, faces, data, dists_or_distMax, useSemivariogram)
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


%% Prelims
% Distance between each pair of points
if nargin < 4 || isempty(dists_or_distMax)  % no input
    dists = meshEdgeGeodesicDistances(verts, faces);
elseif isscalar(dists_or_distMax)           % distMax
    dists = meshEdgeGeodesicDistances(verts, faces, [], [], dists_or_distMax);
elseif ismatrix(dists_or_distMax)           % dists
    dists = dists_or_distMax;
else
    error("Incorrect distances specified");
end

if nargin < 5 || isempty(useSemivariogram)
    useSemivariogram = false;
end

% Difference between each pair of points
diffs = (data - data.').^2 ./ (1+useSemivariogram);


%% Main
% Discretise distance i.e. put into bins
[~,~,distsBinned] = histcounts(dists);
nanmask = ~isnan(dists(:));
[G, Gid] = findgroups(distsBinned(nanmask)); % Gid := unique(distsBinned);

% Mean and std of `diffs` and `dists` within each bin
% These are the x vals, y vals, and errorbars needed
[x,y,e] = deal(nan(max(Gid),1)); % ensure that outputs have nans
outmask = idx2mask(nonzeros(Gid));
[x(outmask),y(outmask),e(outmask)] = splitapply(...
    @(x,y) deal(mean(x), mean(y), std(y)), dists(nanmask), diffs(nanmask), G);

% Plot
if nargout == 0; errorbar(x, y, e); end


end


