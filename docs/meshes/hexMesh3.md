---
layout: default
title: hexMesh3
checksum: 5b691372ae9218fee459a7cfcf91ea4c
parent: meshes
---


 
# HEXMESH Generates 3 dimensional mesh with z a function of x and y
 
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

