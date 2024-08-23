function [verts, faces] = hexMesh(n, seed)
%% HEXMESH Generates equilateral triangle mesh
%% Examples
%   v = hexMesh;
%   [v,f] = hexMesh;
%   [v,f] = hexMesh(9); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
%   [v,f] = hexMesh(10,10); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
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
if nargin < 1 || isempty(n);    n = 20;     end
if nargin < 2 || isempty(seed); seed = -1;  end


%% Vertices
try
    %% Random sampling
    rng(seed);
    v = (1:n)'.*[1,0] + n*[cospi(-2/3), sinpi(-2/3)];
    verts = v;     
    for ii = 1:5
        rm = [cospi(ii/3), sinpi(ii/3); -sinpi(ii/3), cospi(ii/3)];
        verts = [verts; v * rm']; %#ok<AGROW>
    end
    v2 = sampleConvexPolygon(verts, 3*n^2-3*n+1);
    verts = [verts; v2];
    irregular = true; 
catch 
    %% Regular sampling
    % generate verts for 1 triangle
    [x,y] = meshgrid(1:n, 0:n-1);
    mask = (x+y)<=(n);

    v = reshape( x + (0:height(x)-1)'/2  , [], 1);
    v(:,2) = y(:) * sqrt(3)/2;
    v = v(mask,:);

    % rotate 5 times (multiply by transpose of rotation matrix)
    nv = arrayfun(@(t) v*[cos(t) sin(t); -sin(t) cos(t)], pi*(1:5)'/3, 'uni', 0);
    verts = [0 0; v; cell2mat(nv)];
    irregular = false; 
end

if nargout < 2; return; end


%% Faces
faces = delaunay(verts(:,1), verts(:,2));
if irregular; return; end

% Delaunay triangulation isn't perfect dus to collinear points
% Remove faces which seem incorrect (based on edge length > 1.1)
e = decreaseSimplexDimension(faces);                % edges
d = vecnorm(verts(e(:,1),:)-verts(e(:,2),:),2,2);   % distances
w = reshape(d>1.1, [], 3);                          % wrong faces
faces = faces(all(~w,2),:); 

end
