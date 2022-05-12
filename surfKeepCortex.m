function [verts2, faces2, rois2] = surfKeepCortex(verts, faces, rois)
%SURFKEEPCORTEX Remove specified verts and faces from surface patch object
%   Inputs:
%   verts:  N x 3 matrix of all the vertex coordinates
%   faces:  M x 3 vertex of the vertex IDs that make up each face
%           Note that max(faces(:)) = N
%   rois:   N x 1 vector of rois, where 0 -> rois to be excluded
%
%   Outputs: corrected verts, faces, rois
% 
%   based on python package surfdist (Daniel Margulies)
%   https://github.com/NeuroanatomyAndConnectivity/surfdist

roisExcluded = find(~rois);
rois2 = rois(~~rois);

vertIDs = zeros(length(rois), 1);
vertIDs(~~rois) = 1:length(rois2);

facesExcluded = any(ismember(faces, roisExcluded), 2);
faces2 = faces(~facesExcluded, :);
faces2 = vertIDs(faces2);

verts2 = verts(~~rois,:);

end

