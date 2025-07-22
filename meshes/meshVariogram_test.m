%% Test 1: Test single map

[verts, faces] = sphereMesh(40, 'fib'); 
data = sin(2*pi*sum(verts,2)) + 0.5*randn(height(verts), 1);

figure; 
nexttile; patchvfc(verts, faces, data); axis equal tight off; colorbar; 
nexttile; meshVariogram(verts, faces, data); axis square; 


%% Test 2: Test using mesh eigenmodes

[verts, faces] = sphereMesh(10, 'fib'); 
[~, data] = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 16); 

figure;
for ii = (data) %%% Can also change to `abs(data)` %%%
    nexttile; patchvfc(verts, faces, ii); axis equal tight off; colorbar('Location', 'westoutside'); 
    nexttile; meshVariogram(verts, faces, ii); axis square; 
end


%% Test 2b: Test using high-frequency mesh eigenmodes

[verts, faces] = sphereMesh(40, 'fib'); 
[~, data] = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 6, 7*6, 0, 0); 

figure;
for ii = (data)
    nexttile; patchvfc(verts, faces, ii); axis equal tight off; colorbar; 
    nexttile; meshVariogram(verts, faces, ii); axis square; 
end


%% Test 2c: Antipodean parity of odd and even eigengroups

[verts, faces] = sphereMesh(20, 'fib'); 
[s, data] = calc_geometric_eigenmode(struct('vertices', verts, 'faces', faces), 25); 

figure;
for ii = 1:width(data)
    % nexttile; patchvfc(verts, faces, ii); axis equal tight off; colorbar; 
    nexttile; meshVariogram(verts, faces, data(:,ii)); axis square; 
    title(sprintf("Group %i", ceil(sqrt(ii)))); 
end


%% Test 3: Test distMax

[verts, faces] = sphereMesh(60, 'fib'); 
data = sin(2*pi*sum(verts,2)) + 0*randn(height(verts), 1);

figure; 
nexttile; patchvfc(verts, faces, data); axis equal tight off; colorbar; 
nexttile; meshVariogram(verts, faces, data, pi/2); axis square; 


%% Test 4: Timing of higher resolution mesh with distMax

[verts, faces] = sphereMesh(75, 'fib'); 
data = sin(2*pi*sum(verts,2)) + 0*randn(height(verts), 1);

figure;     
nexttile; patchvfc(verts, faces, data); axis equal tight off; colorbar; 
nexttile; tic; meshVariogram(verts, faces, data, pi/20); toc; axis square; 


