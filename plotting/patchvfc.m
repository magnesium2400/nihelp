function p = patchvfc(verts, faces, cdata, varargin)
%% PATCHVFC Wrapper to plot vertices, faces, and color
%% Examples
%   v = rand(100,2); f = delaunay(v); figure; patchvfc(v,f); 
%   rng(1); v = sortrows(rand(100,2)); f = delaunay(v); figure; patchvfc(v,f,(1:100)'); 
%   rng(1); v = sortrows(rand(100,2)); f = delaunay(v); figure; patchvfc(v,f,(1:height(v))','EdgeColor','k'); 
%   rng(1); v = sortrows(rand(100,2)); f = delaunay(v); figure; patchvfc(v,f,(1:height(v))','EdgeColor','k','FaceColor','flat'); 
%   rng(1); v = sortrows(rand(100,2)); f = delaunay(v); figure; patchvfc(v,f,(1:height(f))','EdgeColor','k'); 
%
%   [v,f] = squareMesh; figure; patchvfc(v,f); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,[],'EdgeColor','r'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(v))'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(v))', 'FaceColor', 'flat'); 
%   [v,f] = squareMesh; figure; patchvfc(v,f,(1:height(f))', 'EdgeColor', 'k'); 
%   [v,f] = squareMesh; figure; [d,r] = pdist2(eye(3,2)*10, v, 'euclidean','Smallest',1); patchvfc(v,f,r','EdgeColor','r','LineWidth',2); 
%   [v,f] = sphereMesh; figure; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); patchvfc(v,f,r'); hold on; scat3(eye(4,3),50,'k','filled'); colormap autumn; 
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

[ax, args, ~] = axescheck(verts, faces, cdata, varargin{:}); 
if isempty(ax); ax = gca; end
verts = args{1}; 
faces = args{2}; 
try cdata = args{3}; a = args(4:end); catch; end

% a = varargin;  

if nargin < 3 || isempty(cdata)
    a = [{'FaceColor', 'none', 'EdgeColor', 'k'}, a{:}];
elseif strcmpi(cdata, 'area')
    a = [{'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(verts,faces), 'EdgeColor', 'none'}, a{:}];
elseif numel(cdata) == height(verts)
    a = [{'FaceColor', 'interp', 'FaceVertexCData', double(cdata(:)), 'EdgeColor', 'none'}, a{:}];
elseif numel(cdata) == height(faces)
    a = [{'FaceColor', 'flat', 'FaceVertexCData', double(cdata(:)), 'EdgeColor', 'none'}, a{:}];
elseif isStringScalar(cdata) || ischar(cdata)
    a = [{'FaceColor', cdata}, a{:}]; 
end

p = patch(ax, 'Vertices', verts, 'Faces', faces, a{:});

end
