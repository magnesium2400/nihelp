%% Test 1a: Demo of downsample equilateral mesh

% Params for up- and downsampling
stepSize = randi(4)+3;
stepIter = randi(4)+3;

% Generate high-res mesh
[v,f] = equilateralMesh(randsample(setdiff(4:2:20,18),1));
[v,f] = increasePatch(v,f,stepSize*floor(3*stepIter/2));

% Downsample mesh
[~,f2,v2] = decreaseRegularPatch(f,stepSize,stepIter,v);

% Visualise output
figure;
patchvfc(v,f,'w'); hold on; view(2); axis image off;
patchvfc(v2,f2,[], 'LineWidth', 4, 'EdgeColor', 'r');


%% Test 1b: Compare with increasePatch

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


%% Test 2: fsaverage5 examples
% Note that fsaverage is icosahedral mesh upsampled 32x
% So exact downsampling will only work by 2x, 4x, 8x, 16x

% Generate mesh equivalent to fsaverage
% Meshes are equivalent even though vertices do not correspond
[v,f] = equilateralMesh(20);
[v,f] = increasePatch(v,f,2^6);
% v = v./vecnorm(v,2,2);

figuremax; tiledlayout('flow', 'TileSpacing', 'tight');
for ii = 2.^(1:4)
    % Downsample as desired
    [~,f2,v2] = decreaseRegularPatch(f,ii,[],v);

    % Visualise output
    nexttile;
    patchvfc(v,f,'w'); hold on; view(2); axis image off;
    patchvfc(v2,f2,[], 'LineWidth', 2, 'EdgeColor', 'r');
    title(sprintf('Downsample factor %d',ii))
end


%% Test 3a: Downsample fsLR-32k to 3.6k vertices
% Note that fsLR-32k is icosahedral mesh upsampled 57x
% So exact downsampling will only work by 3x or 19x 

% Generate mesh equivalent to fsLR-32k
% Meshes are equivalent even though vertices do not correspond
[v,f] = equilateralMesh(20);
[v,f] = increasePatch(v,f,57);
% v = v./vecnorm(v,2,2);

% Downsample as desired
[~,f2,v2] = decreaseRegularPatch(f,3,13,v);

% Visualise output
figure;
patchvfc(v,f,'w'); hold on; view(2); axis image off;
patchvfc(v2,f2,[], 'LineWidth', 2, 'EdgeColor', 'r');


%% Test 3b: Downsample fsLR-32k to 92 vertices
% Note that fsLR-32k is icosahedral mesh upsampled 57x
% So exact downsampling will only work by 3x or 19x 

% Generate mesh equivalent to fsLR-32k
% Meshes are equivalent even though vertices do not correspond
[v,f] = equilateralMesh(20);
[v,f] = increasePatch(v,f,57);
% v = v./vecnorm(v,2,2);

% Downsample as desired
[~,f2,v2] = decreaseRegularPatch(f,19,[],v);

% Visualise output
figure;
patchvfc(v,f,'w'); hold on; view(2); axis image off;
patchvfc(v2,f2,[], 'LineWidth', 2, 'EdgeColor', 'r');


%% Test 4: Downsample fsLR-164k 
% Note that fsLR-164k is icosahedral mesh upsampled 128x
% So exact downsampling will work by powers of 2
% Same as fsaverage7

% Generate mesh equivalent to fsLR-164k
% Meshes are equivalent even though vertices do not correspond
[v,f] = equilateralMesh(20);
[v,f] = increasePatch(v,f,2^7);
% v = v./vecnorm(v,2,2);

% Downsample as desired
[~,f2,v2] = decreaseRegularPatch(f,2^4,[],v);

% Visualise output
figure;
patchvfc(v,f,'w'); hold on; view(2); axis image off;
patchvfc(v2,f2,[], 'LineWidth', 2, 'EdgeColor', 'r');


%% Test 5: Timings on icosahedron
fprintf('\n'); 
for ii = 2.^(1:7)
    [v,f] = equilateralMesh(20); 
    [v2,f2] = increasePatch(v,f,ii); 
    tic; 
    [~,f3,v3] = decreaseRegularPatch(f2,ii,[],v2); 
    fprintf("Downsampling mesh with %*d faces (%*d vertices) to %*d faces took %.4f seconds.\n", ...
        [6 height(f2)], [6 height(v2)], [2 height(f3)], toc);
    assert( isequalTriangulation(f,f3) ); 
end


