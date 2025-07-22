%% User inputs
splits = {...
    [2 25], [2 5 5], ...
    [2 25 3], [2 5 5 3], [2 5 3 5], ...
    [2 25 2 5], [2 2 25 5], [2 2 5 5 5]};

hemi = {'lh', 'rh'};

midthicknessPath = 'fsLR_32k_midthickness-%s.vtk';
spherePath = 'fsLR_32k_sphere-%s.vtk';
medialPath = 'fsLR_32k_cortex-%s_mask.txt';


%% Helpers
trimFaces   = @(v,f,r) argout(@() trimExcludedRois(v,f,r,'removeUnconnected',0),2);
isConn      = @(v,f,r) isConnected(trimFaces(v,f,r), nnz(r));
allConn     = @(v,f,r) all(arrayfun( @(ii) isConn(v,f,r==ii) , unique(nonzeros(r)) ));
paren       = @(a,b) a(b); 

getFileHash([], 'saveDependencies', true); 


%% Main
for h = 1:length(hemi)

    % Prelims for each hemi
    [v,f] = read_vtk(sprintf(midthicknessPath, hemi{h}));
    s = read_vtk(sprintf(spherePath, hemi{h}));
    m = readmatrix(sprintf(medialPath, hemi{h}));

    [VERTS, FACES] = trimExcludedRois(v.', f.', m);
    SPHERE = trimExcludedRois(s.', f.', m);

    fa = calcFaceArea(v', f'); 
    va = faces2verts(f', fa); 
    writematrix( fa, sprintf(midthicknessPath+"_faceArea.txt", hemi{h}) ); 
    writematrix( va, sprintf(midthicknessPath+"_vertArea.txt", hemi{h}) ); 


    for ii = 1:length(splits)
        split = splits{ii}; 
        splitString = strjoin(string(split),'-');

        % Find the parcellation
        ROIS = equalAreaPCARecursion2(VERTS, FACES, SPHERE, split);
        rois = unmask(m,ROIS,0);
        if ~allConn(VERTS, FACES, ROIS)
            warning("Disconnected regions in " + hemi{ii} + " " + splitString);
        end

        % Find the centroids and distances
        cents = zeros(prod(split),1); 
        dists = nan(height(VERTS), 1); 
        for r = 1:max(ROIS)
            [vr,fr] = trimExcludedRois(v', f', rois==r); 
            [c,d] = meshFrechet(vr,fr); 
            cents(r) = paren(find(rois==r), c); %#ok<FNDSB>
            dists(rois==r) = d(:,c); 
        end

        % Output to text files
        outString = sprintf("./EqualAreaPCA_%iParcels_%s_%s",...
            prod(split),splitString,hemi{h}); 
        writematrix(rois, outString+".txt");
        writematrix(calcRoiArea(VERTS, FACES, ROIS), outString+"_areas.txt");
        writematrix(cents, outString+"_roiFrechet.txt");
        writematrix(dists, outString+"_dists.txt");

        % Figure
        fig = figure('Position', [680,511,1200,400]); 
        [~,~,~,tl]= plotBrain(v', f', rois, dists, 'colorbarOn', true, ...
            'view', {[-90 0], [90 0]}, 'groupBy', 'data'); 
        scat3(v(:,cents)', [], 'r', 'filled', 'Parent', nexttile(tl{1},1)); 
        scat3(v(:,cents)', [], 'r', 'filled', 'Parent', nexttile(tl{1},2)); 
        savecf(outString, [".fig", ".png"]);

    end
end

