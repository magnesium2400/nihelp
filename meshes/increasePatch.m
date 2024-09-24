function [vn, fn] = increasePatch(v,f,r)
%% INCREASEPATCH Increases patch resolution (subdivides triangles) by any factor
%% Timings for upsampling icosahedron (20 faces --> * faces)
%  | Factor | Vertices | Faces  | Time (s) | 
%  | :----: | :------: | :----: | :------: |
%  | 2      | 42       | 80     | 0.0047   |
%  | 4      | 162      | 320    | 0.0047   |
%  | 8      | 642      | 1280   | 0.0037   |
%  | 16     | 2562     | 5120   | 0.0076   |
%  | 32     | 10242    | 20480  | 0.1227   |
%  | 64     | 40962    | 81920  | 1.3347   |
%  | 128    | 163842   | 327680 | 18.6262  |
%
%
%% Examples
% See `increasePatch_test.m` for examples
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
% Vertices and faces
nv = height(v); 
nf = height(f); 

% Find unique edges
% and how all the edges map on to these unique ones (order and orientation)
e = [ f(:,[1,2]) ; f(:,[2,3]) ; f(:,[3,1]) ]; 
[es, eo] = sort(e,2);               % edges sorted and edge orientation
[E, ~, ej] = unique(es,'rows','sorted');
ej = reshape(ej, [], 3);            % ID of each half-edge in each face
eo = reshape(eo(:,1), [], 3)-1;     % Orientation of hlaf-edge in each face

nE = height(E); 


%% Delaunay template
% Generate an example delaunay triangle of size r
% This will be duplicated across all the faces (with indicies renumbered as
% needed)

z = zeros(1,r-1);
vnc = [r,0; 0,r; 0,0];
vne = [r-1:-1:1, z, 1:r-1;...
       1:r-1, r-1:-1:1, z ]';
[a,b] = meshgrid(1:r-2, r-2:-1:1); 
vnf = [tril2vec(b,0,1), tril2vec(a,0,1)];
clear a b

D = delaunay([vnc; vne; vnf]); 


%% Make all new vertices
% Iterate over all unique edges to find vertex coordinates 
% of the new vertices which will lie on the edges
vne = arrayfun2mat(@(ii) [r-1:-1:1; 1:r-1]'/r*v(E(ii,:),:)   , (1:nE)'); 

% Iterate over all faces to find vertex coordinates
% of the new vertices which will lie on the faces
vnf = arrayfun2mat(...
    @(ii) barycentricToCartesian(...
        triangulation(f,v),...
        ii*ones(height(vnf),1),...
        [vnf,r-sum(vnf,2)]/r...
    ), ...
    (1:nf)'); 

% New vertices
vn = [v; vne; vnf];


%% Make all new faces
% Copy one delaunay template for each face
% Then reindex the verts to refer to the new ones

% Create 3d matrix where each page will have the new faces for each face
fn = repmat(D, 1, 1, nf);

% Flag to correct for orientation of each half-edge
flipflag = @(vec,flag) (1-flag)*vec + (flag)*flip(vec); 

% Reindex the vertices for each page/face
% i.e. convert from local indices (for each face) to global indices (for the
% whole mesh)
for ii = 1:size(fn,3)

    % Corners (i.e. 3 corners for each face)
    % Edge 1
    % Edge 2
    % Edge 3
    % Vertices within the face

    old = [1 2 3, ...
       flipflag(     4:r+2,   eo(ii,1) ), ...
       flipflag(   r+3:2*r+1, eo(ii,2) ), ...
       flipflag( 2*r+2:3*r,   eo(ii,3) ), ...
       3*r+(1:((r-2)*(r-1))/2)];

    new = [f(ii,:), ...     
        nv+(ej(ii,1)-1)*(r-1) + (1:r-1), ...
        nv+(ej(ii,2)-1)*(r-1) + (1:r-1), ...
        nv+(ej(ii,3)-1)*(r-1) + (1:r-1), ...
        nv+nE*(r-1)+(ii-1)*(r-2)*(r-1)/2 + (1:(r-2)*(r-1)/2)];

    % fn(:,:,ii) = changem(fn(:,:,ii), new, old); 
    fn(:,:,ii) = renumber(fn(:,:,ii), new, old); 

end

% New faces - combine each page
fn = reshape(permute(fn,[1 3 2]),[],3); 


end


