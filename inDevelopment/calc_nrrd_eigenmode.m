function [nrrdModes, s] = calc_nrrd_eigenmode(nrrdpath, k, sigma, lump)
%% CALC_NRRD_EIGENMODE Calculate volumetric eigenmodes
%% Inputs
%  `nrrdpath - path to nrrd (string | char array)`
%
%  `k - number of eigenmodes (positive integer scalar)`
%
%  `sigma - approximation of first eigenvalue (scalar)`
%
%  `lump - flag to lump mass matrix (false (default) | true)`
% 
% 
%% Outputs
%  `nrrdModes - array of eigenmodes (matrix)`
%
%  `s - struct containing eigenmodes, mass matrix, verts, etc. (struct)`
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


% Prelims
if nargin < 2 || isempty(k);        k = 6;          end
if nargin < 3 || isempty(sigma);    sigma = -0.01;  end
if nargin < 4 || isempty(lump);     lump = false;   end

vol = nrrdread(nrrdpath); 
mask = logical(vol); 

% calculate tetrahedral mesh in voxel space
xyz = vol2xyz(vol, mask); 
as = alphaShape(xyz); 

% calculate modes in native space
xyzNative = affineVerts(xyz, inv(nrrdinfo(nrrdpath).SpatialMapping.A), 1); 
s = calc_geometric_eigenmode(...
    struct('vertices', xyzNative, 'faces', as.alphaTriangulation), ...
    k, sigma, lump);       

% output in voxel space as 4-d matrix too
nrrdModes = zeros([numel(vol), k]);
nrrdModes(mask(:),:) = s.evecs; 
nrrdModes = reshape(nrrdModes, [size(vol), k]); 

end

