%% Test 1: Example test with meshgrid

[x,y,z] = meshgrid(1:10); v = [x(:), y(:), z(:)];
d = delaunay(v);
t = tetrahedra2triangulation(d);

tic;
[d2, d2Flag] = triangulation2tetrahedra(t(randperm(height(t)),:));
toc;

assert(isequal(sortmat(d), sortmat(d2)))
assert(matrixRowsEqual(d,d2))

%%%%%%%%%%%% If figures are desired, uncomment the following: %%%%%%%%%%%%%
% figure;
% ax = nexttile; tetramesh(d,v);
% hold on; scatter3(v(:,1),v(:,2),v(:,3), 'filled');
% 
% ax(2) = nexttile;  trimesh(t, v(:,1), v(:,2), v(:,3), 'FaceColor', 'none');
% hold on; scatter3(v(:,1),v(:,2),v(:,3), 'filled'); axis equal; 
% 
% ax(3) = nexttile; tetramesh(d2,v, -d2Flag, 'FaceAlpha', 0.5);
% hold on; scatter3(v(:,1),v(:,2),v(:,3), 'filled');
% 
% ax(4) = nexttile; 
% scat3(v, [], faces2verts(d2, d2Flag), 'filled'); axis equal;
% 
% linkaxes(ax);



%% Test 2: Series of tests, code compressed
v = {sphereMesh(10), rand(100,3), [randn(100,3); randn(100,3)*4]};
cellfun(@(x) assert(t2t(x)),v);


%% Test 3: Time based on number of points
v = arrayfun(@(n) randn(n,3), 100:100:500, 'Uni', 0); 
cellfun(@(x) height(delaunay(x))*4 ,v)' %#ok<NOPTS>
cellfun(@(x) assert(t2t(x)),v);


%% HELPERS

function [out, tet2, tet2Flag] = t2t(v)
tet = delaunay(v);
tri = tetrahedra2triangulation(tet);
tic;
[tet2, tet2Flag] = triangulation2tetrahedra(tri(randperm(height(tri)),:));
toc;
out = (isequal(sortmat(tet), sortmat(tet2))) & (matrixRowsEqual(tet,tet2));
assert(out);
end

% sortmat = @(x) sortrows(sort(x,2));
function out = sortmat(x); out = sortrows(sort(x,2)); end

% matrixRowsEqual = @(x,y) all(arrayfun( @(ii) any( all(ismember(y,x(ii,:)),2) )  , 1:height(x) )) &&  all(arrayfun( @(ii) any( all(ismember(x,y(ii,:)),2) )  , 1:height(y) ));
function out = matrixRowsEqual(x,y)
out=all(arrayfun( @(ii) any( all(ismember(y,x(ii,:)),2) )  , 1:height(x) )) &&  ...
    all(arrayfun( @(ii) any( all(ismember(x,y(ii,:)),2) )  , 1:height(y) ));
end

