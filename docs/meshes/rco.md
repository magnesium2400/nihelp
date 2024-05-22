---
layout: default
title: rco
checksum: c4f42439b53150b514c5a361f0baacba
parent: meshes
---


 
# RCO Generates surface mesh of (pseudo)rhombicuboctahedron
 
# Examples
```matlab
[v,f] = rco; figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
[v,f] = rco('pseudo'); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
[v,f] = rco; [v,f] = augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
[v,f] = rco('pseudo'); [v,f] = augmentFace(v,f); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

