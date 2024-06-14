---
layout: default
title: roiBoundary
checksum: 20c8ebb899372583c130d4f7dbb1dbb3
parent: meshes
---


 
# ROIBOUNDARY Boundary vertices for one or more ROIs on triangulated surface
 
# Examples
```matlab
[v,f] = sphereMesh; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); figure; scat3(v,[],r','.'); hold on; scat3(v(roiBoundary(f,r'),:));
[v,f] = sphereMesh; [~,r] = pdist2(eye(4,3),v,'euclidean','Smallest',1); figure; scat3(v,[],r','.'); hold on; scat3(v(roiBoundary(f,r',1),:));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

