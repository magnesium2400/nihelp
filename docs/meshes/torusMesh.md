---
layout: default
title: torusMesh
checksum: 16cf0813e7f5e7804b9cce9d20e92a74
parent: meshes
---


 
# TORUSMESH Generate vertices and faces of toroidal mesh
 
# Examples
```matlab
v = torusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3));
[v,f] = torusMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal;
[v,f] = torusMesh(45,10,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

