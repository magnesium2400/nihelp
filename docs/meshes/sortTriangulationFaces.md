---
layout: default
title: sortTriangulationFaces
checksum: 92abb861103d64d5312c3c3456ac8373
parent: meshes
---


 
# SORTTRIANGULATION Sorts each face in triangulation whilst preserving orientation
 
# Examples
```matlab
f = [4 2 3; 4 2 1], sortTriangulationFaces(f)
f = delaunay([1 1; 1 2; 2 2; 2 1]), sortTriangulationFaces(f)
v = table2array(combinations(1:3,1:3)); f = delaunay(v), sortTriangulationFaces(f)
rng(1); v = rand(10,2); f = delaunay(v); sortTriangulationFaces(f)
```
 
# TODO
-  docs 
 
# See Also

sortTriangulation, ismemberTriangulation, isequalTriangulation

 
# Authors

Mehul Gajwani, Monash University, 2024

