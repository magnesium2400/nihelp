---
layout: default
title: calcRoiArea
checksum: f3df6a76bc8a154f3e3624988d67d73a
parent: meshes
---


 
# CALCROIAREA gets area of each ROI in a surface patch object, ignores verts indexed as zero
 
# Examples
```matlab
[x,y]=meshgrid((1:40)); z=x.^2+y.^2; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=(repmat([1 2 2 3 3 3 3 3 4 4],4,40)); a=calcRoiArea(v,f,r(:)); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a(r(:))); colorbar;
[x,y] = meshgrid(1:25); z=peaks(25)+x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=kron(magic(5), ones(5)); a=calcRoiArea(v,f,r(:)); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', a(r(:)));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024 Stuart Oldham, Monash University

