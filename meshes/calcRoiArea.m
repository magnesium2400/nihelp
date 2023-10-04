function out = calcRoiArea(verts, faces, rois)
%% CALCROIAREA gets area of each ROI in a surface patch object
% ignores verts indexed as zero

% Make a version of faces where instead of indexing the vertex ID, index
% the particularly ROIs that make up the vertices that make up that face
roi_faces = rois(faces);
out = nan(max(rois), 1);

% Lopp over each ROI
for i = 1:max(rois) % ignores parcs indexed as zero

    % Find the faces which are contained entirely within the ROI i.e., all
    % three vertices which make up a face should be assigned to that ROI
    current = all(roi_faces==i,2);

    % Surface area calculation
    a = verts(faces(current, 2), :) - verts(faces(current, 1), :);
    b = verts(faces(current, 3), :) - verts(faces(current, 1), :);
    c = cross(a, b, 2);
    areaTri = 1/2 * (sqrt(sum(c.^2, 2)));

    out(i) = sum(areaTri);

end

end