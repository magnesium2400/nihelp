---
layout: default
title: torusMesh
checksum: 722f0ac704ad2a3033c2efe5f562144b
parent: meshes
---


 
# TORUSMESH Generate vertices and faces of toroidal mesh
 
# Examples
```matlab
v = torusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3));
[v,f] = torusMesh(21); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal; view(3);
[v,f] = torusMesh(98,10,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',(1:height(v)).', 'EdgeColor', 'none'); axis equal; view(3); colormap([hsv;hsv]);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

