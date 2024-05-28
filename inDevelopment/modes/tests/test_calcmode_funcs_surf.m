clear
clc

% Load surface
medmask = readmatrix('data/surfaces/atlas-hcp_space-fsLR_den-32k_hemi-L_medialMask.txt');
cortexInds = find(medmask);

[vertices, faces] = read_vtk('data/surfaces/atlas-hcp_space-fsLR_den-32k_surf-midthickness_hemi-L_surface.vtk');
[vertices_masked, faces_masked] = surfKeepCortex(vertices.', faces.', medmask);
nverts = size(vertices_masked, 1);

%% Test with minimum input parameters
fprintf('Test with minimum input parameters... ')
[surf, V, D, M, S] = calc_geometric_eigenmode(struct('vertices', vertices_masked, 'faces', faces_masked));
assert(isfield(surf, 'evecs'));
assert(isfield(surf, 'evals'));
assert(all(size(V) == [nverts, 10]));
assert(length(D) == 10);
assert(all(size(M) == [nverts, nverts]));
assert(all(size(S) == [nverts, nverts]));
fprintf('passed\n')

%% Test with all input parameters
fprintf('Test with all input parameters... ')
[surf, V, D, M, S] = calc_geometric_eigenmode(struct('vertices', vertices_masked, 'faces', faces_masked), 200, -0.01, false);
assert(isfield(surf, 'evecs'));
assert(isfield(surf, 'evals'));
assert(all(size(V) == [nverts, 200]));
assert(length(D) == 200);
assert(all(size(M) == [nverts, nverts]));
assert(all(size(S) == [nverts, nverts]));
fprintf('passed\n')

%% Test with lump = True
fprintf('Test with lump = True... ')
[surf, V, D, M, S] = calc_geometric_eigenmode(struct('vertices', vertices_masked, 'faces', faces_masked), 10, -0.01, true);
assert(isfield(surf, 'evecs'));
assert(isfield(surf, 'evals'));
assert(all(size(V) == [nverts, 10]));
assert(length(D) == 10);
assert(all(size(M) == [nverts, nverts]));
assert(all(size(S) == [nverts, nverts]));
assert(all(M == diag(diag(M)), 'all'))
fprintf('passed\n')

%% Test with a surface that has 'mass' and 'stiffness' fields
fprintf('Test with a surface that has `mass` and `stiffness` fields... ')
clear surf
[surf, M, S] = calc_mass_stiffness(struct('vertices', vertices_masked, 'faces', faces_masked), false);
surf.mass = M;
surf.stiffness = S;

[surf, V, D, M, S] = calc_geometric_eigenmode(surf, 10, -0.01, false);
assert(isfield(surf, 'evecs'));
assert(isfield(surf, 'evals'));
assert(all(size(V) == [nverts, 10]));
assert(length(D) == 10);
assert(all(size(M) == [nverts, nverts]));
assert(all(size(S) == [nverts, nverts]));
fprintf('passed\n')
