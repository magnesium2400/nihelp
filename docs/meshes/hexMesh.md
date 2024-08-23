---
layout: default
title: hexMesh
checksum: ab35cb22db1a76a1b40264a48b152364
parent: meshes
---


 
# HEXMESH Generates equilateral triangle mesh
 
# Examples
```matlab
v = hexMesh;
[v,f] = hexMesh;
[v,f] = hexMesh(9); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
[v,f] = hexMesh(10,10); figure; trimesh(f, v(:,1), v(:,2)); axis equal tight;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

