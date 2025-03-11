---
layout: default
title: smoothmap
checksum: 202ad541c34c30228b1ef5ef13f63efa
parent: meshes
---


 
# SMOOTHMAP Generates a smooth scalar function on a surface using its eigenmodes
 
# Examples
```matlab
[v,f] = sphereMesh; c = smoothmap(v,f,20);
[v,f] = sphereMesh; c = smoothmap(v,f,20); figure; patchvfc(v,f,c);
[v,f] = sphereMesh(50); c = smoothmap(v,f,99,1); figure; patchvfc(v,f,c);
[v,f] = torusMesh(50);  c = smoothmap(v,f,99,1); figure; patchvfc(v,f,c);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

