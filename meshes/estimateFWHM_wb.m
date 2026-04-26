function [fwhm, Vl, Vg] = estimateFWHM_wb(vertices, faces, rois, data)

%% Prelims / setup
% Inputs
if isempty(rois); rois = true(height(data),1); end % If no ROI provided, use all nodes
rois = logical(rois);
data = data(rois,:);

%%% These calcs could be moved outside/precomputed if needed
% Pre-calculate mean edge length
edgeLength = calcEdgeLength(vertices, faces);

% Pre-calculate edges that will be needed
adj = triangulation2adjacency(faces, 'returnSparse', true);
roi_adj = triu(adj(rois, rois));
[rows, cols] = find(roi_adj);


%% Main calculations
Vg = var(data, 1, 1);
Vl = mean( (data(rows,:) - data(cols,:)).^2, 1 );

% Combine using the FWHM formula
ratio = Vl ./ (2 * Vg);
fwhm = edgeLength * sqrt(-2 * log(2) ./ log(1 - ratio));

end





