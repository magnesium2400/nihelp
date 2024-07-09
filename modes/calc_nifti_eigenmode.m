function [niftiModes, s] = calc_nifti_eigenmode(niftipath, k, sigma, lump)
%% CALC_NIFTI_EIGENMODE Calculate volumetric eigenmodes
%% Inputs
%  `niftipath - path to nifti (string | char array)`
%
%  `k - number of eigenmodes (positive integer scalar)`
%
%  `sigma - approximation of first eigenvalue (scalar)`
%
%  `lump - flag to lump mass matrix (false (default) | true)`
% 
% 
%% Outputs
%  `niftiModes - array of eigenmodes (matrix)`
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

vol = niftiread(niftipath); 
mask = logical(vol); 

% calculate tetrahedral mesh in voxel space
xyz = vol2xyz(vol, mask); 
as = alphaShape(xyz); 

% calculate modes in native space
xyzNative = affineVerts(xyz, niftiinfo(niftipath).Transform.T, 1); 
s = calc_geometric_eigenmode(...
    struct('vertices', xyzNative, 'faces', as.alphaTriangulation), ...
    k, sigma, lump);       

% output in voxel space as 4-d matrix too
niftiModes = zeros([numel(vol), k]);
niftiModes(mask(:),:) = s.evecs; 
niftiModes = reshape(niftiModes, [size(vol), k]); 

end

