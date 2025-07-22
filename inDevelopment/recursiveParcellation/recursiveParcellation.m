function out = recursiveParcellation(func, splits, params)


splits = reshape(splits, 1, []);
% working = zeros(length(verts), length(splits));

% first cut
working(:,1) = func(splits(1), params);
working = working .* [1, zeros(1, length(splits)-1)]; % nVerts * nSplits


for ii = 2:length(splits)
    % turn the ROI indices (which are in base splits(ii)) into unique ROI IDs
    weights = [cumprod(splits(2:ii-1), 2, 'reverse'), 1];
    rois = working(:,1:ii-1) * weights';
    p = prod(splits(1:ii-1)) - 1;

    % then split each of these ROIs
    for jj = 0:p
        % mask = rois==jj;
        % verts2 = verts(mask,:); 
        % tmp = unmask(mask, (1:nnz(mask))', 0);
        % faces2 = faces( sum(ismember(faces, find(mask)),2)>1 ,:); 
        
        mask = rois==jj; 
        % [verts2, faces2] = trimExcludedRois(verts, faces, mask, 'removeUnconnected', false);
        working(mask, ii) = ...
            func(splits(ii), params, mask);
            % equalAreaPCASplit2(verts2, faces2, sphere(mask,:), splits(ii), vertAreas(mask));
    end

end

out = working * [cumprod(splits(2:end), 2, 'reverse'), 1]' + 1;


end

