---
layout: default
title: cuboidDelaunay
checksum: 58211a706f3a6f672ee8de6400aa6ca4
parent: volumes
---


 
# CUBOIDDELAUNAY Marching-cubes like algorithm to generate tetrahedral mesh from volume
 
# Examples
```matlab
cuboidDelaunay(ones(5,5,5));
V = ones(5,5,5); V(86:end) = 0; [f,v] = cuboidDelaunay(V); figure; tetramesh(f,v);
V = xyz2vol(solidTorusMesh(10)+50,[],0); [f,v] = cuboidDelaunay(V); figure; tetramesh(f,v);
```
 
# TODO
-  plenty of options to speed this up if desired e.g. find status of each vertex and expand to faces at end, using parfor etc 
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

