---
layout: default
title: decreaseSimplexDimension
checksum: 2ad343e403d594ce7c7fe355017dff54
parent: matrices
---


 
# DECREASESIMPLEXDIMENSION Decrease dimensionality of e.g. surface triangulation
 
# Examples
```matlab
v = rand(100,2); f = delaunay(v); e = decreaseSimplexDimension(f);
v = rand(100,3); f = delaunay(v); e = decreaseSimplexDimension(f);
v = rand(100,2); f = delaunay(v); e = decreaseSimplexDimension(f); figure; plotLines(v(e(:,1),:),v(e(:,2),:));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

