---
layout: default
title: hexMesh3
checksum: 6faaad75bc302e684bda997c2d8dec8d
parent: meshes
---


 
# HEXMESH3 Generates 3 dimensional hexagonal mesh with z a function of x and y
 
# Examples
```matlab
v = hexMesh3;
v = hexMesh3; figure; scatter3(v(:,1), v(:,2), v(:,3), '.');
[v,f] = hexMesh3(5);
[v,f] = hexMesh3(5); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
[v,f] = hexMesh3(5,5); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
[v,f] = hexMesh3(9,[],@(x,y)(x-5).^2-(y-5).^2); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

