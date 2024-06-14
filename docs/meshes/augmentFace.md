---
layout: default
title: augmentFace
checksum: 4fad7c5f94597ad5558899640949c164
parent: meshes
---


 
# AUGMENTFACE Replaces face in surface mesh with tetrahedron
 
# Usage Notes

Old faces are removed from their location in the `faces` matrix, and new faces are all added to the end

 
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

