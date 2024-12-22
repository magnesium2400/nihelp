%%% Shared variables
doPlot = 0; %#ok<*UNRCH>


%% Test 1: Simple tests with 1D kernels in each dimension
% User input
V = ones(2,3,4);

v = vol2xyz(V);

k = [0;0;1];
out = full(logical(volume2adjacency(V,k)));
assert(isequal( sum(out,2),v(:,1)>1 ))
assert(isequal( sum(out)' ,v(:,1)<size(V,1) ))
if doPlot; figure; plotVolume(V, 'c', sum(out)); colorbar; end

k = [0 0 1];
out = full(logical(volume2adjacency(V,k)));
assert(isequal( sum(out,2),v(:,2)>1 ))
assert(isequal( sum(out)' ,v(:,2)<size(V,2) ))
if doPlot; figure; plotVolume(V, 'c', sum(out)); colorbar; end

k = cat(3,0,0,1);
out = full(logical(volume2adjacency(V,k)));
assert(isequal( sum(out,2),v(:,3)>1 ))
assert(isequal( sum(out)' ,v(:,3)<size(V,3) ))
if doPlot; figure; plotVolume(V, 'c', sum(out)); colorbar; end


%% Test 2: Test ball mesh and compare to pdist neighborhood distance
% User inputs
r = 2;
neighbors = randsample([6,18,26],1); % can also choose 1 from 6, 18 or 26

% volume2adjacency
v = ballMesh(r)+r+1;
V = xyz2vol(v, [], 0);
out = full(logical(volume2adjacency(V,neighbors)));

% check with pdist
searchRadius = sqrt(floor((neighbors+4)/10)); % 6->1,18->2,26->3
comp = squareform(pdist(vol2xyz(V,logical(V)))<=searchRadius);

% compare
assert(isequal(comp, out))


%% Test 3a: Plot - show vertex degree in high N mesh
% User inputs
r = 7;
neighbors = 26; 

v = ballMesh(r);
V = xyz2vol(v+r+1, [], 0);
a = logical(volume2adjacency(V, neighbors));
[s,t] = find(a);

if doPlot
    figure;
    scat3(v, [], sum(a), 'filled');
    axis image; xyzlabel; colorbar; hold on;
end


%% Test 3b: Plot - show connections between vertices in low N mesh
% User input
r = 2;

v = ballMesh(r);
V = xyz2vol(v+r+1, [], 0);
a = full(volume2adjacency(V, 26));
[s1,t1] = find(a==1);
[s2,t2] = find(a==2);
[s3,t3] = find(a==3);

if doPlot
    figure;
    scat3(v, [], sum(logical(a)), 'filled');
    axis image; xyzlabel; colormap(flip(copper)); colorbar; hold on;
    plotLines(v(s1,:), v(t1,:), 'Color', [1 0 0 0.5]);
    plotLines(v(s2,:), v(t2,:), 'Color', [0 1 0 0.5]);
    plotLines(v(s3,:), v(t3,:), 'Color', [0 0 1 0.5]);
end

