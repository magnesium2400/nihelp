---
layout: default
title: cuboidSurface
checksum: d605dab0799ca377b63288461672f862
parent: meshes
---


 
# CUBOIDSURFACE Generates regular square mesh on surface of rectangular prism
 
# Examples
```matlab
[v,f] = cuboidSurface; figure; trimesh(f, v(:,1), v(:,2), v(:,3), 'FaceColor', 'none');
[v,f] = cuboidSurface(3,4,5); figure; trimesh(f, v(:,1), v(:,2), v(:,3), 'FaceColor', 'none'); axis equal;
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

