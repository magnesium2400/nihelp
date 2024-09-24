---
layout: default
title: circleMesh3
checksum: 23b988c6ddc3c5a316f7fee94b09385e
parent: meshes
---


 
# CIRCLEMESH3 Generates 3 dimensional circular mesh with z a function of x and y
 
# Examples
```matlab
v = circleMesh3;
v = circleMesh3; figure; scatter3(v(:,1), v(:,2), v(:,3), '.');
[v,f] = circleMesh3(5);
[v,f] = circleMesh3(5); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
[v,f] = circleMesh3(5,5); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
[v,f] = circleMesh3(9,[],@(x,y)(x-5).^2-(y-5).^2); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

