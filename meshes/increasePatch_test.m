%%% Shared data/variables
%#ok<*ASGLU,*NASGU>

doPlot = 0; 


%% One triangle
[v,f] = deal([0 0; 1 0; 0 1], [1 2 3]);
r = 2;
ipTest(v,f,r,doPlot); 

%% Two triangles
[v,f] = deal([eye(3);eye(3)+1], [1,2,3; 4,5,6]); 
r = 13;
ipTest(v,f,r,doPlot); 

%% Torus
[v,f] = torusMesh; 
r = 6;
ipTest(v,f,r,doPlot); 

%% fsLR32k
[v,f] = equilateralMesh(20); 
r = 57; 
ipTest(v,f,r,doPlot); 

%% fsaverage5
[v,f] = equilateralMesh(20); 
r = 2^5;
ipTest(v,f,r,doPlot); 

%% Compare with decreaseRegularPatch

% Params for up- and downsampling
stepSize = randi(10)+10;

% Generate high-res mesh
[v,f] = equilateralMesh(randsample(setdiff(8:2:20,18),1));
[v2,f2] = increasePatch(v,f,stepSize);

% Downsample mesh
[~,f3,v3] = decreaseRegularPatch(f2,stepSize,[],v2);

% Check that the original is recovered
assert(isequal(v,v3))
assert(isequalTriangulation(f,f3))


%% Test 5: Timings on icosahedron
fprintf('\n'); 
for ii = 2.^(1:7)
    [v,f] = equilateralMesh(20); 
    tic; 
    [v2,f2] = increasePatch(v,f,ii); 
    fprintf("Upsampling mesh with %*d faces to %*d faces (%*d vertices) took %.4f seconds.\n", ...
        [2 height(f)], [6 height(f2)], [6 height(v2)], toc);
end


%% Helpers
function passed = ipTest(v,f,r,p)

%%% Calculations
[vn, fn] = increasePatch(v,f,r);
e  = unique(sort(decreaseSimplexDimension(f ), 2), 'rows');
en = unique(sort(decreaseSimplexDimension(fn), 2), 'rows');

%%% Checks
passed = false; 

% Number of new vertices
assert(height(vn) == height(v) + (r-1)*height(e) + (r-1)*(r-2)/2*height(f))

% Number of new edges
assert(height(en) == r*height(e) + 3*r*(r-1)/2*height(f))

% Number of new faces
assert(height(fn) == r*r*height(f))

% Face orientation
assert(all( faceOrientation(fn)>0 ))

% Euler characteristic
assert(meshEuler(f, height(v)) == meshEuler(fn, height(vn)));

passed = true; 
clear e en

%%% Plot
if p
    figure;  patchvfc(v, f, 'w', 'LineWidth', 2, 'EdgeColor', 'r');
    hold on; patchvfc(vn, fn, 'none', 'LineStyle', ':', 'LineWidth', 1);
    axis equal tight off;
end

end

