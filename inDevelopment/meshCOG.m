function [c, weights] = meshCOG(verts, facesOrWeights)
%% MESHCOG Returns (weighted) centre of gravity of a mesh
%% Syntax
%  out = meshCOG(verts)
%  out = meshCOG(verts, faces)
%  out = meshCOG(verts, weights)
%  out = meshCOG(verts, alphaRadius)
%
%
%% Description
% `out = meshCOG(verts)` returns the centre of gravity of the point cloud given
% in `verts`. Notably, this may lay outside the point cloud (in particular, for
% non-convex sets).
%
% `out = meshCOG(verts, faces)` returns the centre of gravity of the mesh given
% by `verts` and `faces`, where the contribution of each vertex is given by the
% area surrounding it. Here, the area is calculated based on the faces
% associated with that vertex. This approach is better suited to meshes where
% the area of each vertex is not the same. The centre of gravity may lay outside
% the mesh.
%
% `out = meshCOG(verts, weights)` returns the weighted mean of the points given
% in `verts`, with each point weighted by the corresponing value in `weights`. 
%
% `out = meshCOG(verts, alphaRadius)` first computes the alphaShape of the point
% cloud in `verts` with radius given by `alphaRadius`, then uses the faces of
% the `AlphaTriangulation` to find the mesh centre of gravity. 
% 
% 
%% Examples
% Simple examples in 2D and 3D
%   v = squareMesh(9); c = meshCOG(v); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');    
%   v = hexMesh3(9); c = meshCOG(v); figure; scat3(v,[],'k','.'); hold on; scat3(c,20,'r','filled');   
%
% Example using `faces`
%   [v,f] = squareMesh(9); [c,w] = meshCOG(v,f); figure; scat(v,[],w,'filled'); hold on; scat(c,[],'r','filled');    
%
% Examples using random meshes
%   v     = squareMesh(9,9); c = meshCOG(v  ); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');    
%   [v,f] = squareMesh(9,9); c = meshCOG(v,f); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');    
%
% Example with unequal area faces
%   [v,f] = hexMesh(9); v(:,1) = v(:,1) .* (1+(v(:,1)>0)*9) + 9; c = meshCOG(v  ); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');   
%   [v,f] = hexMesh(9); v(:,1) = v(:,1) .* (1+(v(:,1)>0)*9) + 9; c = meshCOG(v,f); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');   
%
% Example using alphaRadius
%   v = rand(99,2); c = meshCOG(v,2); figure; scat(v,[],'k','.'); hold on; scat(c,20,'r','filled');    
%
%
%
%% Input Arguments
% `verts - point coordinates (matrix)`
%
% `faces - triangulation of point locations (matrix)`
%
% `weights - weighting of each point in calculation in centre (vector)`
%
% `alphaRadius - alpha shape radius to use to compute triangulation of point
% cloud (positive scalar)`
%
%
%% Output Arguments
% `c - mesh centre of gravity (row vector)`
%
% `weights - contribution of each vertex to the mean (column vector)`
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% See Also
% `meshFrechet`, `meshIncentre`, `meshCircumcentre`
%
%

n = height(verts);

if nargin < 2 || isempty(facesOrWeights)
    weights = ones(n, 1);
elseif strcmp(facesOrWeights, 'unweighted')
    weights = ones(n, 1);
elseif numel(facesOrWeights) == n
    weights = facesOrWeights(:);
elseif numel(facesOrWeights) == 1
    as = alphaShape(verts);
    as.Alpha = 2;
    faces = as.alphaTriangulation;
    weights = faces2verts(faces, calcFaceArea(verts, faces), n);
elseif ismatrix(facesOrWeights)
    weights = faces2verts(facesOrWeights, calcFaceArea(verts, facesOrWeights), n);
end

c = (weights' * verts) / sum(weights);

end
