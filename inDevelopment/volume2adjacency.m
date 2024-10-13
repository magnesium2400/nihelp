function [A, V] = volume2adjacency(V, nNeighbors_or_kernel)
%% VOLUME2ADJACENCY Converts volumetric data to adjacency matrix (e.g. between adjacent voxels)
%% Syntax
%  A = volume2adjacency(V, nNeighbors);
%  A = volume2adjacency(V, kernel);
%  [A,Vidx] = volume2adjacency(___);
%
%
%% Examples
% See `volume2adjacency_test.m` for examples
%
%
%% Description
% `A = volume2adjacency(V, nNeighbors)` calculates the adjacency matrix for the
% volumetric data contained in `V`, where the adjacency between voxels is
% defined according to the number of neighbors (6 for direct connections, 18 for
% square-diagonally-adjacent, or 26 for cube-diagonally-adjacent).
%
% `A = volume2adjacency(V, kernel)` calculates the adjacency matrix according to
% a custom user-specified kernel.
%
% `[A,Vidx] = volume2adjacency(___)` also returns a volumetrix mask `Vidx`
% showing the index of the vertices in V.
%
%
%% Input Arguments
% `V - Volumetric data (3D matrix)` This data will be treated as binary data.
%
% `nNeighbors - flag to specify inbuilt kernel types (6 | 18 | 26)` If set to 6,
% the kernel will connect voxels to the 6 voxels that can be reached in 1 direct
% step in any of the 6 directions (up/down/left/right/forward/backward), akin to
% the centres of each face of a Rubik's cube from the core. If set to 18, the
% kernel will connect voxels to the 18 voxels that can be reached in 1 or 2
% direct steps in any of the 6 directions, akin to the centres and edges of each
% face of a Rubik's cube. If set to 26, the kernel will connect voxels to the 26
% voxels that surround a given voxel.
%
% `kernel - kernel that defines adjancency between voxels (3D matrix)` This
% should be a 3D matrix where each dimension is of odd size and the centre of
% the kernel represents the central voxel that is being compared to. The centre
% of the kernel should be set to 0 (false).
%
%
%% Output Arguments
% `A - adjacency matrix (2D logical matrix)` Here, the voxels are indexed in
% order of appear in `V`. This is the same as the values in `Vidx`.
%
% `Vidx - mask of voxel indices (3D matrix)` This matrix will be the same size
% and V and will have non-zero values in the same locations. Here, the non-zero
% values will be the (linear) indices corresponding to the positions in `A`.
%
%
%% TODO
% * create volumetric2graph which allows for specificiation of radius
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%


%% Inputs
assert(ndims(V) <= 3 && ndims(nNeighbors_or_kernel) <= 3, ...
    "Only 3d matrices are supported at present");

V(logical(V)) = 1:nnz(V);

if isscalar(nNeighbors_or_kernel);  k = getKernel(nNeighbors_or_kernel);
else;                               k = nNeighbors_or_kernel; end


%% Prelims
A = false(nnz(V),nnz(V));

nd = 3; % nd = max(ndims(V), ndims(k)); % only for 3d data at present
sz = size(V,1:nd);
kd = (size(k,1:nd)-1)/2; % Kernel Delta, i.e. offset in each direction

% Create new version of V with buffer on each side
V2 = zeros(sz + kd*2);
V2((1:sz(1))+kd(1), (1:sz(2))+kd(2), (1:sz(3))+kd(3)) = V;


%% Calculations
% Find the non-zeros in the kernel, relative to the centre
[x,y,z] = ind2sub(size(k), find(k));
d = [x,y,z] - kd - 1;

% For each non-zero value in the kernel, shift the volume and see where it
% overlaps with the original
for ii = 1:nnz(k)
    V3 = V2((1:sz(1))+kd(1)-d(ii,1), (1:sz(2))+kd(2)-d(ii,2), (1:sz(3))+kd(3)-d(ii,3));
    V4 = V & V3;
    A(sub2ind(size(A), V(V4), V3(V4))) = true;
end


end


function k = getKernel(n)
switch n
    case 6
        idx = [5 11 13 15 17 23];
    case 18
        idx = [2 4 5 6 8 10 11 12 13 15 16 17 18 20 22 23 24 26];
    case 26
        idx = setdiff(1:27,14);
    otherwise
        error("Kernel can only have 6, 18, or 26 neighbors.");
end
k = reshape(full(sparse(idx,1,1,27,1)),3,3,3);
end





