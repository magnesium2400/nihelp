function [verts2, faces2, rois2] = mergeVerts(verts, faces, combs, rois)
%% MERGEVERTS Combine several vertices into one in a mesh
%% Examples
% See `examples_meshes_coincidence.mlx`
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if isvector(combs) && ~iscell(combs);   combs = {combs(:)'};
elseif isnumeric(combs);                combs = mat2cell(combs, ones(height(combs,1)), width(combs));
end

keep = true(height(verts), 1);

for ii = 1:length(combs)

    verts2combine = combs{ii};

    verts2combine = sort(verts2combine, 'ascend');
    v1 = verts2combine(1);                          % this will be kept

    verts(v1,:) = mean( verts(verts2combine,:) );   % set pos of new vertex

    faces(ismember(faces,verts2combine)) = v1;      % reindex other vert to first
    faces(sum(faces==v1,2) > 1,:) = [];             % remove faces with multiple verts

    % remove the old vertex and reindex faces/verts
    keep(verts2combine(2:end)) = false;

end


[verts2, faces2] = trimExcludedRois(verts, faces, keep);

if nargout > 2 && nargin > 3 && ~isempty(rois)
    rois2 = rois(keep);
end


end