---
layout: default
title: augmentFace
checksum: 0858a10873478c641787d70751ffd012
parent: meshes
---


 
# AUGMENTFACE Replaces face in surface mesh with tetrahedron
 
# Examples
```matlab
v=[eye(3); 0 0 0]; f=[1 2 3; 1 4 2; 1 3 4; 2 4 3]; [v,f]=augmentFace(v,f);
[v,f]=squareMesh3(3); [v,f]=augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal
[v,f]=squareMesh3(5); [v,f]=augmentFace(v,f,1:2:height(f)); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal
v=eye(3); f=1:3; for ii=1:3;[v,f]=augmentFace(v,f); end; figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

