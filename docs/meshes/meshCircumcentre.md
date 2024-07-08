---
layout: default
title: meshCircumcentre
checksum: b07b99396bab82986b4a429d09025dd2
parent: meshes
---


 
# MESHCIRCUMCENTRE Find the point with the least maximum distance from mesh boundary
 
# Examples
```matlab
[v,f] = hexMesh; meshCircumcentre(v,f)
[v,f] = hexMesh; c = meshCircumcentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
[v,f] = squareMesh3; m = (v(:,1)<10)|(v(:,2)<5); [v,f] = trimExcludedRois(v,f,m); c = meshCircumcentre(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
```
 
# TODO
-  docs 
-  consider weighting dists by area at each vertex 
-  consider adding radii to output 
 
# Authors

Mehul Gajwani, Monash University, 2024

