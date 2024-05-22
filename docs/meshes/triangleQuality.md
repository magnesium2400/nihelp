---
layout: default
title: triangleQuality
checksum: 0437e440cd0a01253a4364abb60b5521
parent: meshes
---


 
# TRIANGLEQUALITY Closeness to equilaterality as defined by LaPy
 
# Examples
```matlab
rng(1); v=rand(400,2); f=delaunay(v); v(:,3)=1; q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
[v,f]=squareMesh3(20); q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
[v,f]=squareMesh3(20); v(:,1)=v(:,1)+kron(ones(20,1)/2,(0:19)'); v(:,2)=v(:,2)*sqrt(3)/2; q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
[v,f]=squareMesh3(20,1); q=triangleQuality(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceVertexCData', q, 'FaceColor', 'flat'); colorbar;
```
