---
layout: default
title: faceEdgeLength
checksum: 7b982febfa8333bffe7328dcc9ba6343
parent: meshes
---


 
# FACEEDGELENGTH Calculates the length of each edge on each face in a mesh
 
# Examples
```matlab
[v,f] = sphereMesh; l = faceEdgeLength(v,f);
[v,f] = sphereMesh; l = faceEdgeLength(v,f); figure; patchvfc(v,f,max(l,[],2),'EdgeColor','k');
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

