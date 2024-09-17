%% Example 1a: Simple example

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 100);
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 5);

figuremax; tmp = []; 
for ii = [map, s.map_surrs]
    nexttile; plotBrain(s.vertices, s.faces, [], ii, 'colorbarOn', true, 'colormap', @bluewhitered, 'view', {3});
    nexttile; meshVariogram(s.vertices, s.faces, ii); 
    if isempty(tmp); tmp = ylim; else; ylim(tmp); end
end


%% Example 1b: If you don't use enough modes, the variogram will not be replicated

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 50);
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 5);

figuremax; tmp = []; 
for ii = [map, s.map_surrs]
    nexttile; plotBrain(s.vertices, s.faces, [], ii, 'colorbarOn', true, 'colormap', @bluewhitered, 'view', {3});
    nexttile; meshVariogram(s.vertices, s.faces, ii); 
    if isempty(tmp); tmp = ylim; else; ylim(tmp); end
end


%% Example 1c: However, lower wavelength patterns can use fewer modes

[v,f] = sphereMesh(40, 'fib');
map = sin(pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 50);
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 5);

figuremax; tmp = []; 
for ii = [map, s.map_surrs]
    nexttile; plotBrain(s.vertices, s.faces, [], ii, 'colorbarOn', true, 'colormap', @bluewhitered, 'view', {3});
    nexttile; meshVariogram(s.vertices, s.faces, ii); 
    if isempty(tmp); tmp = ylim; else; ylim(tmp); end
end


%% Example 2a: More features - `resample` to reuse values from original map

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 100);
[~,out] = calc_eigenstrap(s, 'map', map, 'nSurrogates', 5, 'resample', true);

figuremax; tmp = []; 
for ii = [map, out]
    nexttile; plotBrain(s.vertices, s.faces, [], ii, 'colorbarOn', true, 'colormap', @bluewhitered, 'view', {3});
    nexttile; meshVariogram(s.vertices, s.faces, ii); 
    if isempty(tmp); tmp = ylim; else; ylim(tmp); end
end


%% Example 2b: More features - `mapName` to read a map from the struct

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));
s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 100);
s.('mymap') = map; clear map; 
s = calc_eigenstrap(s, 'mapName', 'mymap'); 
disp(s); 


%% Example 2c: More features - `mapName` to set the name of the map/surrs for saving data

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 100);
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2); %%% Default name is 'map'
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2, 'mapName', 'estrap1');
s = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2, 'mapName', 'estrap2');

disp("s = ");
disp(s);


%% Example 2d: More features - `seed` to set the seed for reproducibility
% Note that first two rows are the same, and third row is different

[v,f] = sphereMesh(40, 'fib');
map = sin(2*pi*sum(v,2));

s = calc_geometric_eigenmode(struct('vertices', v, 'faces', f), 100);
[~,out1] = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2, 'seed', 1);
[~,out2] = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2, 'seed', 1);
[~,out3] = calc_eigenstrap(s, 'map', map, 'nSurrogates', 2, 'seed', 2);

figuremax; tmp = []; 
for ii = [out1, out2, out3]
    nexttile; plotBrain(s.vertices, s.faces, [], ii, 'colorbarOn', true, 'colormap', @bluewhitered, 'view', {3});
    nexttile; meshVariogram(s.vertices, s.faces, ii); 
    if isempty(tmp); tmp = ylim; else; ylim(tmp); end
end





