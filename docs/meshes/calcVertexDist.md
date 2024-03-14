---
layout: default
title: calcVertexDist
checksum: 99d8f75e9c84a9a2763989882c9efd0d
parent: meshes
---


 
# CALCVERTEXDIST average distance from vertex to each of its neighours
 
# Examples
```matlab
[x,y]=meshgrid(1:10); z=zeros(size(x)); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexDist(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', a);
[x,y]=meshgrid((1:10).^2); z=x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexDist(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', a);
[x,y]=meshgrid(1:20); z=peaks(20); v=[x(:),y(:),z(:)]; f=delaunay(x,y); a=calcVertexDist(v,f); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'interp', 'FaceVertexCData', a);
[v,f] = sphereMesh; a = calcVertexDist(v,f); figure; patch('Vertices',v,'Faces',f,'FaceColor','interp','FaceVertexCData',a); colorbar;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

