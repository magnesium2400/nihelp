% loadenv('.env');
fprintf('NEUROMAPS_DATA set to %s\n', getenv('NEUROMAPS_DATA')); 
doPlot = false;


assert(~isempty(which('gifti'))); % requires `gifti` package for reading files
%#ok<*UNRCH,*NBRAK2,*ALIGN>


%% fsLR surfaces
atlas = "fsLR";
density = ["4k", "8k", "32k", "164k"];
hemi = ["L", "R"];
key = ["inflated", "midthickness", "sphere"];

if doPlot; figure; end
for d=density; for h=hemi; for k=key
            p = fetch_atlas(atlas, d, h, k);
            g = gifti(p);
            if doPlot; nexttile; plotBrain(g.vertices, g.faces); end
end; end; end


%% fsLR desc
atlas = "fsLR";
density = ["4k", "8k", "32k", "164k"];
hemi = ["L", "R"];
key = ["midthickness"];
desc = ["nomedialwall", "sulc", "vaavg"];

if doPlot; figure; end
for d=density; for h=hemi; for k=key; for e = desc
                g = gifti(fetch_atlas(atlas, d, h, k));
                m = gifti(fetch_atlas(atlas, d, h, k, 'desc', e));
                if doPlot; nexttile; plotBrain(g.vertices, g.faces, [], m.cdata); end
end; end; end; end


%% fsLR in fsaverage space
atlas = "fsLR";
density = ["4k", "8k", "32k", "164k"];
hemi = ["L", "R"];
key = ["sphere"];

if doPlot; figure; end
for d=density; for h=hemi; for k=key
            p = fetch_atlas(atlas, d, h, k, 'space', "fsaverage");
            g = gifti(p);
            if doPlot; nexttile; plotBrain(g.vertices, g.faces); end
end; end; end


%% fsaverage surfaces
atlas = "fsaverage";
density = ["3k", "10k", "41k", "164k"];
hemi = ["L", "R"];
key = ["inflated", "pial", "white", "sphere"];

if doPlot; figure; end
for d=density; for h=hemi; for k=key
            p = fetch_atlas(atlas, d, h, k);
            g = gifti(p);
            if doPlot; nexttile; plotBrain(g.vertices, g.faces); end
end; end; end


%% fsaverage desc
atlas = "fsaverage";
density = ["3k", "10k", "41k", "164k"];
hemi = ["L", "R"];
desc = ["nomedialwall", "sulc", "vaavg"];

if doPlot; figure; end
for d=density; for h=hemi; for e = desc
            g = gifti(fetch_atlas(atlas, d, h, "pial"));
            m = gifti(fetch_atlas(atlas, d, h, "midthickness", 'desc', e));
            if doPlot; nexttile; plotBrain(g.vertices, g.faces, [], m.cdata); end
end; end; end

