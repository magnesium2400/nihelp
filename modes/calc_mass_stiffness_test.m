% TODO: Add correctness test for volumes

%%% Shared variables

%%% Generate random surface where all faces are equilateral triangles
[v,f] = equilateralMesh(randsample([4 6 8 12 14 16 20], 1)); 
nDoubles = 0; 
for ii = 1:5
    if randn(1) > 0; [v,f] = increasePatch(v,f); nDoubles = nDoubles + 1; end
end
[v,f] = augmentFace(v,f,find(randn(height(f),1)>0)); 

%%% Uncomment if visualisation required
% figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', v(:,3)); view(3); axis equal off tight; 

%%% Stiffness and mass are related to adj matrix and deg sequence
expectedAdj = logical(triangulation2adjacency(f));
expectedDeg = sum(expectedAdj); 


%% Test 1: Surface with lump set to false
% For stiffness and mass matrices, check that (i) elements are present only
% between connected edges; (ii) off-diagonal elements match prediction;
% (iii) on-diagonal elements match prediction.

s = calc_mass_stiffness(struct('vertices', v, 'faces', f), false); 

assert(isequal( expectedAdj+eye(height(s.vertices)) , logical(s.stiffness) ))
assert(allclose( s.stiffness - diag(diag(s.stiffness))  , -expectedAdj/sqrt(3) ))
assert(allclose( full(diag(s.stiffness)), expectedDeg'/sqrt(3) ))

assert(isequal( expectedAdj+eye(height(s.vertices)) , logical(s.mass) ))
assert(allclose( s.mass - diag(diag(s.mass))  , sqrt(3)/24*expectedAdj/(4^nDoubles) ))
assert(allclose( full(diag(s.mass)), sqrt(3)/24*expectedDeg'/(4^nDoubles) ))


%% Test 2: Surface with lump set to true
% For stiffness matrix, check that (i) elements are present only between
% connected edges; (ii) off-diagonal elements match prediction; (iii)
% on-diagonal elements match prediction. For mass matrix (which will be
% diagonal given that lump is true), check on-diagonal elements only. 

s = calc_mass_stiffness(struct('vertices', v, 'faces', f), true); 

assert(isequal( expectedAdj+eye(height(s.vertices)) , logical(s.stiffness) ))
assert(allclose( s.stiffness - diag(diag(s.stiffness))  , -expectedAdj/sqrt(3) ))
assert(allclose( full(diag(s.stiffness)), expectedDeg'/sqrt(3) ))

assert(isequal( logical(eye(height(s.vertices))) , logical(s.mass) ))
assert(allclose( s.mass  ,  sqrt(3)/12*diag(expectedDeg)/(4^nDoubles) ))


%% Test 3: Check that code runs for various volumes (not correctness)

% rng(1); 
cms = @(v,f) calc_mass_stiffness(struct('vertices', v, 'faces', f)); 
assertions = @(s) assert(...
    isfield(s,'mass') && isfield(s,'stiffness') && ...
    all(size(s.mass)     ==height(s.vertices)) && ~any(isnan(s.mass)     ,'all') && ...
    all(size(s.stiffness)==height(s.vertices)) && ~any(isnan(s.stiffness),'all') ...
    );

% random volume
v = rand(100,3); f = delaunay(v); 
s = cms(v,f); assertions(s); 

% random alpha volume
v = rand(100,3); f = alphaShape(v); 
s = cms(v,f.alphaTriangulation); assertions(s);

% disconnected volume
v1 = rand(100,3); f1 = delaunay(v); 
v2 = rand(10,3)+3; f2 = delaunay(v2); 
v = [v1; v2]; f = [f1; f2+100]; 
s = cms(v,f); assertions(s);

% flat volume, almost in plane
v = [ [1:5,1:5]' , kron([1;2],ones(5,1)) , ones(10,1) ] + rand(10,3)/1e9;
f = [1 2 6 7]+(0:3)';
s = cms(v,f); assertions(s);

