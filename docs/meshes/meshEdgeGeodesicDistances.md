---
layout: default
title: meshEdgeGeodesicDistances
checksum: 6f8f087fd1719e6f3969bd709096fe9c
parent: meshes
---


 
# MESHEDGEGEODESICDISTANCES Calculats distances between vertices on 3d triangulated mesh

Time taken on fsLR downsampled meshes: 5k, 1.5 seconds; 10k, 6 seconds; 32k, 50 seconds

 
# Examples
```matlab
[x,y] = meshgrid(1:20,1:30); x=x(:); y=y(:); z=ones(size(x)); f=delaunay(x,y); v=[x,y,z]; d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:21:400; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
[x,y] = meshgrid(1:20); x=x(:); y=y(:); z=10*sin(x)+0.1*(y-10).^2; f=delaunay(x,y); v=[x,y,z]; d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:40:400; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
[v,f] = torusMesh(10); d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:8:90; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'k'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
[v,f] = torusMesh(200); d = meshEdgeGeodesicDistances(v,f); figure; for ii = 1:900:9900; nexttile; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', d(:,ii), 'EdgeColor', 'none'); hold on; scatter3(v(ii,1), v(ii,2), v(ii,3), 50, 'red', 'filled'); axis square equal tight off; view(3); colorbar; end;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

