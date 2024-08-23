---
layout: default
title: rco
checksum: c8d577a860e81d1e7b95782b44013aac
parent: meshes
---


 
# RCO Generates surface mesh of (pseudo)rhombicuboctahedron
 
# Examples
```matlab
v = rco;
v = rco;           figure; scatter3(v(:,1),v(:,2),v(:,3),[],(1:24)','filled'); axis equal;
v = rco('pseudo'); figure; scatter3(v(:,1),v(:,2),v(:,3),[],(1:24)','filled'); axis equal;
```
```matlab
[v,f] = rco; figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
[v,f] = rco('pseudo'); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
[v,f] = rco(0.5); figure; trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

