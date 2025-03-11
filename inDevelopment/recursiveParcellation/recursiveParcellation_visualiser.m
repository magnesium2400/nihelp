function r = recursiveParcellation_visualiser(func, splits, p, doPlot)

v = p.verts; f = p.faces; 

tic
fprintf('%4i parcels:\t', prod(splits));
r = recursiveParcellation(func, splits, p);
toc
% fprintf('%i parcels:\tElapsed time is %f seconds\n', prod(splits), toc); 

tmp = faces2verts(f, calcFaceArea(v,f)); % tmp = splitapply0(@sum, va, r); 
% tmp = r; 
tmp = calcRoiArea(v,f,r);

if ~doPlot; return; end


%%
figure; tiledlayout(2,2); 
nexttile; 
plotBrain(v,f,r,tmp, 'BoundaryMethod', 'faces', 'colormap', @winter); 
colorbar;


%%
nexttile; 
swarmchart(onesz(tmp), tmp, 'XJitter', 'density');
yline(mean(tmp), 'LineWidth', 3); 
yline(mean(tmp)*[0.9 1.1], 'LineWidth', 1, 'LineStyle', ':'); 
xticks([]); 
ylim(minmax(tmp)); ylabel('Area (target ± 10%)');
xlabel(sprintf('%i out of %i out of area bounds', nnz(tmp<mean(tmp)*0.9 | tmp>mean(tmp)*1.1) , numel(tmp))); 
ylimitation('min', mean(tmp)*0.9, 'max', mean(tmp)*1.1);


%%
ax = nexttile; 
g = colorRois(f,r);
plotBrain(v,f,g(r),g(r), 'colormap', lines(max(g))); 
title(length(unique(r))); 


end
