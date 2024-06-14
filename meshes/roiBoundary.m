function [boundaryVerts, boundaryFaces] = roiBoundary(faces, rois, n)
%% ROIBOUNDARY Boundary vertices for one or more ROIs on triangulated surface
%% Examples
%   [v,f] = sphereMesh; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); figure; scat3(v,[],r','.'); hold on; scat3(v(roiBoundary(f,r'),:));
%   [v,f] = sphereMesh; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); figure; scat3(v,[],r','.'); hold on; scat3(v(roiBoundary(f,r',1),:));
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

rf = rois(faces);

if nargin < 3 || isempty(n)                                                 % get all faces on boundary between ROIs
    boundaryFaces = any(diff(rois(faces),1,2),2);
    bvMask = repmat(boundaryFaces, 1, 3); 
else
    rfm = ismember(rf,n);                                                   % get faces on boundary of particular ROI(s)
    boundaryFaces = any(sum(rf == permute(n(:), [3 2 1]),2) == 2,3) | ...   % either exactly two vertices labelled `n` on one face
        ( all(diff(sort(rf,2),1,2),2) & any(rfm,2) ) ;                      % or one vertex labelled `n`, and all three different  
    bvMask = rfm & boundaryFaces;
end

boundaryVerts = full(sparse(faces(bvMask),1,true,size(rois,1),1));

end
