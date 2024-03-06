%% Prelims

libraries = {
    '/fs03/kg98/mehul/Assorted Helper Functions', ...
    '/fs03/kg98/mehul/BMH_utils_matlab', ...
    '/fs03/kg98/mehul/REPOS_ONLINE/plotSurfaceROIBoundary', ...
    '/fs03/kg98/mehul/REPOS_ONLINE/BrainEigenmodes'
    };

for ii = 1:length(libraries)
    addpath(genpath(libraries{ii}));
end

%% Read Data

[a,b] = read_vtk('/fs03/kg98/mehul/atlases/D_fsLR-32k/fsLR_32k_sphere-lh.vtk');
cortexMask = readmatrix('/fs03/kg98/mehul/atlases/D_fsLR-32k/fsLR_32k_cortex-lh_mask.txt');
[vSphere, fSphere] = trimExcludedRois(a', b', cortexMask);

%% Generate synthetic data by adding bulb to sphere

vIdx = randi(length(vSphere));
[vSphereNew, bulbKernel] = addBulbToSphere(vSphere, vIdx, 1000, 0.25);

figure; 
plotBrain(vSphereNew, fSphere, ones(length(vSphere), 1), (1:length(vSphere)).', 'view', vSphere(vIdx,:)*rotx(pi/2.2));
hold on; 
scat3(vSphere(vIdx,:)*1.25, 50, 'red', 'filled' );


figure; 
plotBrain(vSphere, fSphere, ones(length(vSphere), 1), bulbKernel);


%% Examples selecting a random vertex
n = 10;
figure; 
tl = tiledlayout('flow');
for ii = 1:n
    vSphereNew = addBulbToSphere(vSphere, randi(length(vSphere)), 1000, 0.25);
    nexttile();
    plotBrain(vSphereNew, fSphere, ones(length(vSphere), 1), 1:length(vSphere));
end


%% Examples moving a point around a specific area
% params
n = 6; % in total n^2 examples will be produced
alpha = pi/20; % the amount to move around the sphere (in radians) when progressively addings bulbs 

% calcs
figure; tiledlayout(n,n);
for ii = 1:n
    for jj = 1:n
        currentPoint = [-cos(jj*alpha), sin(jj*alpha)*cos(ii*alpha), sin(jj*alpha)*sin(ii*alpha)]*100;
        vSphereNew = addBulbToSphere(vSphere, currentPoint, 1000, 0.25);
        nexttile();
        plotBrain(vSphereNew, fSphere, ones(length(vSphere), 1), 1:length(vSphere));
    end
end


%% 
% % % % % 
% % % % % function newVerts = addBulbToSphere(verts, vertexToAdd, kernelRadius, kernelHeight)
% % % % % if nargin < 3; kernelRadius = 1/1000; end
% % % % % if nargin < 4; kernelHeight = 1/4; end
% % % % % 
% % % % % if numel(vertexToAdd) == 1; vertexToAdd = verts(vertexToAdd,:); end
% % % % % 
% % % % % dists = pdist2(verts, vertexToAdd, 'squaredeuclidean');
% % % % % 
% % % % % bulbKernel = 1 + exp(-dists*kernelRadius)*kernelHeight;
% % % % % newVerts = vSphere .* bulbKernel; % implicit expansion
% % % % % end

%%
% tic;
% [em, ev] = calc_network_eigenmode(...
%     calc_surface_connectivity2(struct('vertices', vSphere, 'faces', fSphere)), 10);
% toc;





