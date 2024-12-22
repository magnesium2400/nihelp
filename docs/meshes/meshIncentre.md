---
layout: default
title: meshIncentre
checksum: 01bdf0649cda3c85035c4f32bb5903f1
parent: meshes
---


 
# MESHINCENTRE Find the point with the greatest minimal distance from mesh boundary
 
# Examples
```matlab
[v,f] = hexMesh; meshIncentre(v,f)
[v,f] = hexMesh; c = meshIncentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
[v,f] = squareMesh3; m = (v(:,1)<10)|(v(:,2)<5); [v,f] = trimExcludedRois(v,f,m); c = meshIncentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
```
 
# TODO
-  docs 
-  consider weighting dists by area at each vertex 
-  consider adding radii to output 
 
# Authors

Mehul Gajwani, Monash University, 2024

