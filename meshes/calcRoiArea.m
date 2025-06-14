function out = calcRoiArea(verts, faces, rois, includeBoundary, facesArea)
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
% 
% 


%% Prelims
if nargin < 4; includeBoundary = true; end
if nargin < 5; facesArea = calcFaceArea(verts, faces); end
rf = rois(faces);


%% Calculations
% Just need to get weights for each face/roi
mask = rf == permute(1:max(rois), [1 3 2]); 

if includeBoundary; weights = sum(mask,2)/3;     % any vertex on current ROI
else;               weights = all(mask,2);  end  % all vertices on current ROI; 

out = (facesArea' * squeeze(weights))'; 


end


