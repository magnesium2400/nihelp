---
layout: default
title: squareMesh3
checksum: 4def0321a238e1faeee7f69d0f81d930
parent: meshes
---


 
# SQUAREMESH Generates 3 dimensional mesh with z a function of x and y
 
# Examples
```matlab
[v,f] = squareMesh3;
[v,f] = squareMesh3(5,5);
[v,f] = squareMesh3(9,[],@(x,y)(x-5).^2-(y-5).^2); figure; trimesh(f, v(:,1), v(:,2), v(:,3));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

