function [newVerts, bulbKernel] = addBulbToSphere(verts, vertexToAdd, kernelRadius, kernelHeight)
%% Input Arguments
%  verts - three-column matrix of xyz coordinates making the mesh
%  
%  vertexToAdd - location where the bulb should be added to the mesh (scalar | point in 3d space)
%  Can be specified as either (i) the index of `verts` where the bulb
%  should be added; or (ii) a 3-element row vector of a location in 3d
%  space where the bulb should be added (e.g. one of the rows of `verts`).
%
%%
if numel(vertexToAdd) == 1; vertexToAdd = verts(vertexToAdd,:); end
if nargin < 3; kernelRadius = 1000; end
if nargin < 4; kernelHeight = 1/4; end

dists = pdist2(verts, vertexToAdd, 'squaredeuclidean');
bulbKernel = 1 + kernelHeight*exp(-dists/kernelRadius);
newVerts = verts .* bulbKernel; % implicit expansion, could also use repmat(bulbKernel, 1, 3)
end