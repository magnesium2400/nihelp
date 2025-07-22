
%% User inputs
% splits = {[2 2 5 5 2], [2 5 2 5 2]};
splits = {[2 2 5 5 2], [2 5 2 5 2], [5 2 5 2 2], [2 5 5 2 2], [2 2 5 5 3], [2 5 2 5 3]};
hemi = ["l", "r"];


for h = hemi
    figuremax;
    tl = tiledlayout('flow');
    title(tl, h);

    [v,f] = read_vtk(sprintf('~/kg98_scratch/Priscila/Mehul_parc_surfs/fsaverage5_10k_inflated-%sh.vtk',h));
    s = read_vtk(sprintf('~/kg98_scratch/Priscila/Mehul_parc_surfs/fsaverage5_10k_sphere-%sh.vtk',h));

    m = ~~readmatrix('~/kg98_scratch/Priscila/Mehul_parc_surfs/mask_200.txt');
    if strcmp(h, 'l'); m = m(1:end/2); else; m = m(end/2+1:end); end

    [verts, faces, mask] = trimExcludedRois(v', f', m);
    sphere = s(:,m)';

    nexttile;
    plotBrain(verts, faces); title('surf');
    nexttile;
    plotBrain(sphere, faces, [], verts(:,2)); title('sphere');

    params = struct('verts', verts, 'faces', faces, 'sphere', sphere, ...
        'vertAreas', calcVertexArea(verts, faces));

    for ii = 1:length(splits)
        r = recursiveParcellation(@recursiveParcellation_equalAreaPCA, splits{ii}, params);
        nexttile;
        plotBrain(verts, faces, r);
        t = strrep(num2str(splits{ii}), '  ', '-');
        title(t); 
        writematrix(r, sprintf('~/kg98_scratch/Priscila/Mehul_parc_surfs/fsaverage5_10k_inflated-%sh_%s.txt', h, t));
    end

end


