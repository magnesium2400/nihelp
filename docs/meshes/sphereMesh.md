---
layout: default
title: sphereMesh
checksum: 89e87acbece72c9c5ba41510b784399f
parent: meshes
---


 
# SPHEREMESH Generate vertices and faces of spherical mesh
 
# Examples
```matlab
v = sphereMesh; figure; scatter3(v(:,1),v(:,2),v(:,3));
[v,f] = sphereMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
[v,f] = sphereMesh(45); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

