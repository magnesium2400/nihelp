clear
clc

% Load surface
medmask = readmatrix('data/surfaces/atlas-hcp_space-fsLR_den-32k_hemi-L_medialMask.txt');
cortexInds = find(medmask);

[vertices, faces] = read_vtk('data/surfaces/atlas-hcp_space-fsLR_den-32k_surf-midthickness_hemi-L_surface.vtk');
[vertices_masked, faces_masked] = surfKeepCortex(vertices.', faces.', medmask);
nverts = size(vertices_masked, 1);
surf.vertices = vertices_masked;
surf.faces = faces_masked;

% Calculate modes
nmodes = 100;
[surf, V, D, M, S] = calc_geometric_eigenmode(surf, nmodes, -0.01, false);
% Make first mode constant to avoid warnings
surf.evecs(:, 1) = mean(surf.evecs(:, 1), "all");
params.mass = surf.mass;

data_struct = load('data/empirical/neuromaps_noPET.mat');
data_nmaps = cell2mat(struct2cell(data_struct)).';
data_nmaps = data_nmaps(cortexInds, 1:10);

%% Test with minimum input parameters
fprintf('Test with minimum input parameters... ')
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data_nmaps, surf.evecs);
assert(all(size(corrCoeffs) == [nmodes, 10]))
assert(all(size(recon) == [nverts, nmodes, 10]))
assert(all(size(betaCoeffs) == [nmodes, 1]))
fprintf('passed\n')

%% Test with orthogonal method
fprintf('Test with orthogonal method... ')
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data_nmaps, surf.evecs, 'orthogonal', [], params);
assert(all(size(corrCoeffs) == [nmodes, 10]))
assert(all(size(recon) == [nverts, nmodes, 10]))
assert(all(size(betaCoeffs) == [nmodes, 10]))
fprintf('passed\n')

%% Test with different modesq argument
fprintf('Test with different modesq argument... ')
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data_nmaps, surf.evecs, 'matrix', [1:10, 20:10:100], params);
assert(all(size(corrCoeffs) == [19, 10]))
assert(all(size(recon) == [nverts, 19, 10]))
assert(all(size(betaCoeffs) == [19, 1]))
fprintf('passed\n')

%% Test with orthogonal method and different modesq argument
fprintf('Test with orthogonal method and different modesq argument... ')
[corrCoeffs,recon,betaCoeffs] = calc_eigenreconstruction(data_nmaps, surf.evecs, 'orthogonal', [1:10, 20:10:100], params);
assert(all(size(corrCoeffs) == [19, 10]))
assert(all(size(recon) == [nverts, 19, 10]))
assert(all(size(betaCoeffs) == [100, 10]))
fprintf('passed\n')

