function out = calcRoiArea(verts, faces, rois, includeBoundary)
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

if nargin < 4; includeBoundary = true; end

% Make a version of faces where instead of indexing the vertex ID, index
% the particularly ROIs that make up the vertices that make up that face
roi_faces = rois(faces);
out = nan(max(rois), 1);

% Loop over each ROI
for ii = 1:max(rois) % ignores parcs indexed as zero
    
    if includeBoundary
        weights = sum(roi_faces==ii,2)/3; % any vertex on current ROI
    else
        weights = all(roi_faces==ii,2); % all vertices on current ROI
    end
        
    current = logical(weights); % which faces to calculate

    % Surface area calculation
    a = verts(faces(current, 2), :) - verts(faces(current, 1), :);
    b = verts(faces(current, 3), :) - verts(faces(current, 1), :);
    c = cross(a, b, 2);
    areaTri = 1/2 * vecnorm(c,2,2); %(sqrt(sum(c.^2, 2)));

    out(ii) = sum(areaTri.*weights(current)); % weight according to number of vertices on each face 

end

end




%% Other ways that may be faster/slower depending on the data used
% (e.g. number of vertices, number of (excluded) rois)
% 
% 1. 
% if nargin < 4; includeBoundary = true; end
% rf = rois(faces); fa = repmat(calcFaceArea(verts, faces),1,3); out = nan(max(rois), 1);
% if includeBoundary; for ii = 1:max(rois); out(ii) = sum(fa(rf == ii))/3; end
% else; for ii = 1:max(rois); out(ii) = sum(fa(all(rf == ii,2),1)); end; end
% 
% 2. 
% rf = rois(faces); 
% if ~includeBoundary % include only faces where all vertices are in the same ROI
%     rf = rf .* all( rf==rf(:,1) , 2 ); 
% end
% 
% out = splitapply0(@sum , repmat(calcFaceArea(verts,faces),3,1) , rf(:))/3;



