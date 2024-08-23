---
layout: default
title: equalTorusMesh
checksum: 8f9a00a61734d66863ee2bcc2e794e63
parent: meshes
---


 
# EQUALTORUSMESH Generate vertices and faces of toroidal mesh with equal faces
 
# Examples
```matlab
v = equalTorusMesh; figure; scatter3(v(:,1), v(:,2), v(:,3));
[v,f] = equalTorusMesh(21); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'none'); axis equal; view(3);
[v,f] = equalTorusMesh(98,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',(1:height(v)).', 'EdgeColor', 'none'); axis equal; view(3); colormap([hsv;hsv]);
```
```matlab
[v,f] = equalTorusMesh(60,3,7); figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',calcFaceArea(v,f), 'EdgeColor', 'k'); axis equal tight; view(3); colorbar;
[v,f] = torusMesh(60,3,7);      figure; patch('Vertices', v, 'Faces', f, 'FaceColor', 'flat', 'FaceVertexCData',calcFaceArea(v,f), 'EdgeColor', 'k'); axis equal tight; view(3); colorbar;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

