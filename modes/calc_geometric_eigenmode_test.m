%%% Generate random surface where all faces are equilateral triangles
[v,f] = equilateralMesh(randsample([4 6 8 12 14 16 20], 1)); 
nDoubles = 0; 
for ii = 1:5
    if randn(1) > 0; [v,f] = increasePatch(v,f); nDoubles = nDoubles + 1; end
end
[v,f] = augmentFace(v,f,find(randn(height(f),1)>0)); 

%%% Uncomment if visualisation required
% figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', v(:,3)); view(3); axis equal off tight; 


%% Test 1: Generate mass and stiffness, check size and shape of outputs

[s,V,D,M,S] = calc_geometric_eigenmode(struct('vertices', v, 'faces', f)); %#ok<*ASGLU>

assert(all(isfield(s, {'mass', 'stiffness', 'evecs', 'evals'})))
assert(all( size(s.mass)        == height(v)        ))
assert(all( size(s.stiffness)   == height(v)        ))
assert(all( size(s.evecs)       == [height(v), 10]  ))
assert(all( size(s.evals)       == [10, 1]          ))


%% Test 2: Precomputed mass and stiffness, check size and shape of outputs

[s,M,S] = calc_mass_stiffness(struct('vertices', v, 'faces', f)); 
assert(all(isfield(s, {'mass', 'stiffness'})))

[s,V,D] = calc_geometric_eigenmode(s); 
assert(all(isfield(s, {'mass', 'stiffness', 'evecs', 'evals'})))

assert(all( size(s.mass)        == height(v)        ))
assert(all( size(s.stiffness)   == height(v)        ))
assert(all( size(s.evecs)       == [height(v), 10]  ))
assert(all( size(s.evals)       == [10, 1]          ))


%% Test 3: Change defaults, check size and shape of outputs

[s,V,D,M,S] = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 50, -0.1, true, 0); 

assert(all(isfield(s, {'mass', 'stiffness', 'evecs', 'evals'})))
assert(all( size(s.mass)        == height(v)        ))
assert(all( size(s.stiffness)   == height(v)        ))
assert(all( size(s.evecs)       == [height(v), 50]  ))
assert(all( size(s.evals)       == [50, 1]          ))


%% Test 4: Check orthogonality and visualise square

[v,f] = squareMesh3(40); 

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 49);

assert(allclose( eye(49) , s.evecs' * s.mass * s.evecs ))
assert(all( diff([0; s.evals]) >= 0 ))

figuremax; 
tl = tiledlayout(5, 10, 'TileSpacing', 'tight'); 

nexttile; 
plotSkeleton(v,f); view(2); axis equal tight off; 

for ii = 1:49
    nexttile; 
    trimesh(f, v(:,1), v(:,2), s.evecs(:,ii), 'FaceColor', 'none', 'EdgeColor','interp'); 
    view(2); axis equal tight off; 
end


%% Test 5: Check orthogonality and visualise sphere

[v,f] = sphereMesh(21); 

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 25);

assert(allclose( eye(width(s.evecs)) , s.evecs' * s.mass * s.evecs ))
assert(all( diff([0; s.evals]) >= -1e-12 ))

figuremax; 
plotBrain(v, f, [], s.evecs, 'view', {'lm', 'll'}, 'groupBy', 'data', 'colormap', @bluewhitered, ...
    'tiledlayoutOptions', {5, 5, 'TileSpacing', 'compact'}, ...
    'tiledlayout2options', {1, 2, 'TileSpacing', 'none'});

% figuremax; 
% multiplot(s.evecs, ...
%     @(x) patch('Vertices', s.vertices.*(abs(x)), 'Faces', s.faces, 'FaceVertexCData', x, 'FaceColor', 'interp', 'EdgeColor', 'none'), ...
%     {@() axis('equal', 'tight', 'off'), @()view(3)});



%% Test 6: Check that code runs for various volumes (not correctness)

% rng(1); 
cge = @(v,f) calc_geometric_eigenmode(struct('vertices', v, 'faces', f)); 
assertions = @(s) assert(...
    isfield(s,'mass') && isfield(s,'stiffness') && ...
    all(size(s.mass)     ==height(s.vertices)) && ~any(isnan(s.mass)     ,'all') && ...
    all(size(s.stiffness)==height(s.vertices)) && ~any(isnan(s.stiffness),'all') ...
    );

% random volume
v = rand(100,3); f = delaunay(v); 
s = cge(v,f); assertions(s); 

% random alpha volume
v = rand(100,3); f = alphaShape(v); 
s = cge(v,f.alphaTriangulation); assertions(s);

% disconnected volume
v1 = rand(100,3); f1 = delaunay(v); 
v2 = rand(10,3)+3; f2 = delaunay(v2); 
v = [v1; v2]; f = [f1; f2+100]; 
s = cge(v,f); assertions(s);

% flat volume, almost in plane
v = [ [1:5,1:5]' , kron([1;2],ones(5,1)) , ones(10,1) ] + rand(10,3)/1e9;
f = [1 2 6 7]+(0:3)';
s = cge(v,f); assertions(s);


%% Test 7: Check orthogonality and visualise ball

[v,f] = ballMesh(10); 

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 36);

assert(allclose( eye(width(s.evecs)) , s.evecs' * s.mass * s.evecs ))
assert(all( diff([0; s.evals]) >= -1e-12 ))

figuremax; 
multiplot(s.evecs, @(x) scat3(s.vertices, [], x, 'filled'), @() axis('equal', 'off'));

% figuremax; 
% multiplot(s.evecs, @(x) scat3(s.vertices.*abs(x), [], x, 'filled'), @() axis('equal', 'off'));

