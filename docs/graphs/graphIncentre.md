---
layout: default
title: graphIncentre
checksum: f77ad21da62627594908a1e35536ea87
parent: graphs
---


 
# GRAPHINCENTRE Find the point with the greatest minimal distance from graph boundary
 
# Examples
```matlab
[v,f] = hexMesh; graphIncentre(graph(triangulation2adjacency(f)))
[v,f] = hexMesh; g = graph(triangulation2adjacency(f)); c = graphIncentre(g); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

