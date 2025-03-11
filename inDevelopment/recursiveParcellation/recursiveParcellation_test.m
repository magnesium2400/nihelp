%%% Shared variables

[v,f] = read_vtk('C:\Users\mehul\Documents\PhD\DATA\HCP_Surfaces\fsLR_32k_inflated-lh.vtk');
s = read_vtk('C:\Users\mehul\Documents\PhD\DATA\HCP_Surfaces\fsLR_32k_sphere-lh.vtk');
m = readmatrix('C:\Users\mehul\Documents\PhD\DATA\HCP_Surfaces\fsLR_32k_cortex-lh_mask.txt');

[v,f,~,m] = trimExcludedRois(v', f', m);
va = faces2verts(f, calcFaceArea(v, f));
s = s(:,m)';


p = struct('verts', v, 'faces', f, 'sphere', s, 'vertAreas', va);
func = @recursiveParcellation_modalArea;
doPlot = true;


%% 4
r = recursiveParcellation_visualiser(func, [2 2],                   p, doPlot);  %#ok<*NASGU>
%% 32
r = recursiveParcellation_visualiser(func, [2 2 2 2 2],             p, doPlot);
%% 512
r = recursiveParcellation_visualiser(func, [2 2 2 2 2 2 2 2 2],     p, doPlot);
%% 1024
r = recursiveParcellation_visualiser(func, [2 2 2 2 2 2 2 2 2 2],   p, doPlot);
%% 2048
% r = recursiveParcellation_visualiser(func, [2 2 2 2 2 2 2 2 2 2 2], p, doPlot);
%% 27
r = recursiveParcellation_visualiser(func, [3 3 3],                 p, doPlot);
%% 729
r = recursiveParcellation_visualiser(func, [3 3 3 3 3 3],           p, doPlot);
%% 120
r = recursiveParcellation_visualiser(func, [2 3 4 5],               p, doPlot);
%% 120
r = recursiveParcellation_visualiser(func, [5 4 3 2],               p, doPlot);
%% 100
r = recursiveParcellation_visualiser(func, [5 5 2 2 1],             p, doPlot);
%% 200
r = recursiveParcellation_visualiser(func, [5 5 2 2 2],             p, doPlot);
%% 300
r = recursiveParcellation_visualiser(func, [5 5 2 2 3],             p, doPlot);
%% 400
r = recursiveParcellation_visualiser(func, [5 5 2 2 2 2],           p, doPlot);
%% 500
r = recursiveParcellation_visualiser(func, [5 5 2 2 5],             p, doPlot);
%% 600
r = recursiveParcellation_visualiser(func, [5 5 2 2 2 3],           p, doPlot);
%% 700
r = recursiveParcellation_visualiser(func, [5 5 2 2 7],             p, doPlot);
%% 800
r = recursiveParcellation_visualiser(func, [5 5 2 2 2 2 2],         p, doPlot);
%% 900
r = recursiveParcellation_visualiser(func, [5 5 2 2 3 3],           p, doPlot);
%% 1000
r = recursiveParcellation_visualiser(func, [5 5 2 2 2 5],           p, doPlot);

