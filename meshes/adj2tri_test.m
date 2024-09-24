%%% Shared data
atTest = @(f) isequalTriangulation(f,...
    adj2tri(triangulation2adjacency(f)));


%% Test 1: Regular closed meshes
[~,f] = sphereMesh; 
assert( atTest(f) );

[~,f] = sphereMesh(40, 'fib'); 
assert( atTest(f) );

[~,f] = torusMesh(60); 
assert( atTest(f) );


%% Test 2: Irregular closed meshes
[~,f] = sphereMesh(100,2); 
assert( atTest(f) );


%% Test 3: Meshes with boundary
[v,f] = sphereMesh; 
[~,f] = trimExcludedRois(v,f,v(:,1)>=0); 
assert( atTest(f) );

[~,f] = squareMesh; 
assert( atTest(f) );

[~,f] = hexMesh3(3,2); 
assert( atTest(f) );

[~,f] = hexMesh3(4,3); 
assert( atTest(f) );


%% Test 3b: Check boundary detection of bounded meshes
[v,f] = circleMesh(5+randi(20)); v = v./sqrt(height(v)); 
[f2,b] = adj2tri(triangulation2adjacency(f)); 
assert( isequalTriangulation(f,f2) ); 
assert(isequal( unique(b(:),'sorted') , 1+(1:2*sqrt(height(v)))' ))

[v,f] = hexMesh(6);
[f2,b] = adj2tri(triangulation2adjacency(f)); 
assert( isequalTriangulation(f,f2) ); 
assert(isequal( unique(b(:),'sorted') , find(vecnorm(v,2,2)>5) ))


%% Test 4: Meshes with triangulated ROIs (with and without bound)
[v,f] = hexMesh3(4,4); 
assert( atTest(f) );

[~,f] = sphereMesh(101,2); 
assert( atTest(f) );


%% Test 5: Timing
fprintf('\n'); 
for ii = 20:20:100
    [~,f] = torusMesh(ii); 
    a = triangulation2adjacency(f); 
    tic; f2 = adj2tri(a); 
    fprintf("Regenerating mesh with %*d vertices (%*d faces) took %.4f seconds.\n", ...
        [5 ii^2], [5 height(f)], toc);
    assert( isequalTriangulation(f,f2) ); 
end

