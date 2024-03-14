---
layout: default
title: skeletonise
checksum: ee8378023b1882b284d2ae842f1510a4
parent: meshes
---


 
# SKELETONISE Downsample mesh according to parcellation
 
# Usage Notes

Requires NSB_utils_matlab

 
# Examples
```matlab
[x,y] = meshgrid(1:50); z=10*peaks(50)+x+y; v=[x(:),y(:),z(:)]; f=delaunay(x,y); r=kron(magic(10), ones(5)); [v2,f2]=skeletonise(v,f,r(:)); figure; patch('Vertices', v2, 'Faces', f2, 'FaceColor', 'none');
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

