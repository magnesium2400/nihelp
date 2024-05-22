---
layout: default
title: sphereMesh
checksum: f4e34172e6e908346700feb3ad9a4a23
parent: meshes
---


 
# SPHEREMESH Generate vertices and faces of spherical mesh
 
# Examples
```matlab
v = sphereMesh; figure; scatter3(v(:,1),v(:,2),v(:,3));
[v,f] = sphereMesh(10); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none');
[v,f] = sphereMesh(99); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', (1:height(v)).', 'EdgeColor', 'none'); axis equal off; colormap(hsv); view(3);
[v,f] = sphereMesh(45); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData', calcFaceArea(v,f)); axis equal; colorbar;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

