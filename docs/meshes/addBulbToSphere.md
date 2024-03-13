---
layout: default
title: addBulbToSphere
checksum: 890ce2ad333563aff196d55efef84d3a
parent: meshes
---


 
# ADDBULBTOSPHERE Add distortion to (spherical) mesh at specified location
 
# Examples
```matlab
[v,f]=sphereMesh; tmp=@(v,f) patch('Vertices',v,'Faces',f,'FaceColor','none'); figure; nexttile; tmp(v,f); v2=addBulbToSphere(v,1:100:301,.1,.2); nexttile; tmp(v2,f);
[v,f]=torusMesh; tmp=@(v,f) patch('Vertices',v,'Faces',f,'FaceColor','none'); figure; nexttile; tmp(v,f); v2=addBulbToSphere(v,[2 0 0;-2 0 0],.1,.1); nexttile; tmp(v2,f);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

