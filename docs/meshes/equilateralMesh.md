---
layout: default
title: equilateralMesh
checksum: d472ef744c57997827d2df07d39d8468
parent: meshes
---


 
# EQUILATERALMESH Surface mesh from one of the 8 strictly convex deltahedra
 
# Examples
```matlab
[verts, faces] = equilateralMesh(4);
n=setdiff(4:2:20,18); figure; for ii=n; nexttile; [v,f]=equilateralMesh(ii); trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; end
n=setdiff(4:2:20,18); figure; for ii=n; nexttile; [v,f]=equilateralMesh(ii); trimesh(f,v(:,1),v(:,2),v(:,3)); axis equal; nexttile; bar(calcFaceArea(v,f)); end
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

