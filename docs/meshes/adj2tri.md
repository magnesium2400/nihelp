---
layout: default
title: adj2tri
checksum: 25f6034b2b43c19725d0e2257548ce12
parent: meshes
---


 
# ADJ2TRI Generates triangulation from adjacency matrix
 
# Usage notes
-  Only supports single component meshes 
-  If the mesh is poorly conditioned - in particular, if there is a triangle of vertices that surround 1 or more vertices (especially near the boundary) - the algorithm implemented here may fail (a lot of the complexities of this code are already trying to correct for this) 
 
# Timing
```matlab
| Vertices | Faces | Time (s) |
| :------: | :---: | :------: |
| 400      | 800   | 0.0416   |
| 3600     | 7200  | 0.3062   |
| 10000    | 20000 | 1.6139   |
| 19200    | 39200 | 6.2472   |
| 32400    | 64800 | 21.0001  |
```
 
# Examples

See `adj2tri_test.m` for examples

 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

