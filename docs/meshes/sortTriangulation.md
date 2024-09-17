---
layout: default
title: sortTriangulation
checksum: 1e026bbd95cf73b978849256387cba59
parent: meshes
---


 
# SORTTRIANGULATION Sorts triangulation whilst preserving orientation of faces
 
# Examples
```matlab
f = [4 2 3; 4 2 1], sortTriangulation(f)
f = delaunay([1 1; 1 2; 2 2; 2 1]), sortTriangulation(f)
v = table2array(combinations(1:3,1:3)); f = delaunay(v), sortTriangulation(f)
rng(1); v = rand(10,2); f = delaunay(v); sortTriangulation(f)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024
