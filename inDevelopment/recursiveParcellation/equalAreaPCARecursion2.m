function out = equalAreaPCARecursion2(verts, faces, sphere, splits)
%% equalAreaPCARecursion Takes a brain surface and creates an ~equal area parcellation
% comprised of (roughly) orthogonal cuts, in an order specified by `splits`
%% Examples
%   equalAreaParc = equalAreaPCARecursion(lh_verts, lh_faces, lh_verts_sphere, [2 2 5 5], 0.01); figure; plotBrain(lh_verts, lh_faces, equalAreaParc);
%   [v,f] = trimExcludedRois(lh_verts, lh_faces, logical(Scha17_parcs.lh_scha100)); s = trimExcludedRois(lh_verts_sphere, lh_faces, logical(Scha17_parcs.lh_scha100)); figure; plotBrain(v,f, equalAreaPCARecursion(v,f,s,[2 2 5 5 3], 0.01));
%
%
%% Input Arguments
% `verts - xyz coordinates of brain surface vertices (three column matrix)`
%
% `faces - face triangulation matrix (three column matrix)` Each row in
% `faces` contains the IDs of the vertices that make that face.
%
% `sphere - xyz coordinates of surface inflated to sphere (three column matrix)`
%
% `splits - order of cuts to make to brain surface (vector)` The brain
% surface will be cut according to the entries in `splits`. For example, if
% `splits = [2 2 3 4]`, then the surface will first be cut into 2 pieces;
% each of those pieces will then be cut into another 2 pieces; each of
% those 4 pieces will then be cut into another 3 pieces; and finally each
% of those 12 pieces will be cut into another 4 pieces (for a total of 48
% parcels).
%
% `precisionRequired - error threshold for surface area between ROIs
% (scalar)` For example, a `precisionRequired` set to `0.1` will tolerate
% ROIs being up to 10% off the expected area.
%
%
%% Output Arguments
% `out - vertex level parcellation (vector)`
%
%

vertAreas = faces2verts(faces, calcFaceArea(verts, faces));

splits = reshape(splits, 1, []);
working = zeros(length(verts), length(splits));

% first cut
working(:,1) = equalAreaPCASplit2(verts, faces, sphere, splits(1), vertAreas);


for ii = 2:length(splits)
    % turn the ROI indices (which are in base splits(ii)) into unique ROI
    % IDs
    weights = [cumprod(splits(2:ii-1), 2, 'reverse'), 1];
    p = prod(splits(1:ii-1)) - 1;
    rois = working(:,1:ii-1) * weights';

    % then split each of these ROIs
    for jj = 0:p
        % mask = rois==jj;
        % verts2 = verts(mask,:); 
        % tmp = unmask(mask, (1:nnz(mask))', 0);
        % faces2 = faces( sum(ismember(faces, find(mask)),2)>1 ,:); 
        
        [verts2, faces2, ~, mask] = trimExcludedRois(verts, faces, rois==jj);
        working(mask, ii) = ...
            equalAreaPCASplit2(verts2, faces2, sphere(mask,:), splits(ii), vertAreas(mask));
    end

end

out = working * [cumprod(splits(2:end), 2, 'reverse'), 1]' + 1;

end