function out = calcRoiArea(verts, faces, rois)
%% CALCROIAREA gets area of each ROI in a surface patch object, ignores verts indexed as zero
%% Examples
%   [x,y]=meshgrid((1:40)); z=x.^2+y.^2; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=(repmat([1 2 2 3 3 3 3 3 4 4],4,40)); a=calcRoiArea(v,f,r(:)); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a(r(:))); colorbar;
%   [x,y] = meshgrid(1:25); z=peaks(25)+x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=kron(magic(5), ones(5)); a=calcRoiArea(v,f,r(:)); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a(r(:)));
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% Stuart Oldham, Monash University
% 
% 


% Make a version of faces where instead of indexing the vertex ID, index
% the particularly ROIs that make up the vertices that make up that face
roi_faces = rois(faces);
out = nan(max(rois), 1);

% Loop over each ROI
for ii = 1:max(rois) % ignores parcs indexed as zero

    % Find the faces which are contained entirely within the ROI i.e., all
    % three vertices which make up a face should be assigned to that ROI
    current = all(roi_faces==ii,2);

    % Surface area calculation
    a = verts(faces(current, 2), :) - verts(faces(current, 1), :);
    b = verts(faces(current, 3), :) - verts(faces(current, 1), :);
    
    c = cross(a, b, 2);
    areaTri = 1/2 * (sqrt(sum(c.^2, 2)));
    out(ii) = sum(areaTri);

end

end
