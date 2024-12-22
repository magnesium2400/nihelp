---
layout: default
title: graphCircumcentre
checksum: c1062cd44202c0e40c4c3eb794d139bc
parent: graphs
---


 
# GRAPHCIRCUMCENTRE Find the point with the least maximum distance from graph boundary
 
# Examples
```matlab
[v,f] = hexMesh; graphCircumcentre(graph(triangulation2adjacency(f)))
[v,f] = hexMesh; g = graph(triangulation2adjacency(f)); c = graphCircumcentre(g); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

