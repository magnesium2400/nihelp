---
layout: default
title: joinPatches
checksum: 0049f4a9fa0b30b97b66a43240eceb2e
parent: meshes
---


 
# JOINPATCHES Join 2 sets of verts and faces (and rois) combined into 1 model
 
# Examples
```matlab
[v1,f1] = sphereMesh; [v2,f2] = torusMesh; [v,f]=joinPatches(v1/2,f1,v2,f2); figure; patch('Vertices',v,'Faces',f);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

