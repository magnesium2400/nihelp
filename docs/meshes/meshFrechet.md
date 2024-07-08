---
layout: default
title: meshFrechet
checksum: e432fe669da4f996752b11db4adf02d4
parent: meshes
---


 
# MESHFRECHET Finds the (approximate) Riemannian centre of mass of mesh
 
# Examples
```matlab
[v,f] = hexMesh; c = meshFrechet(v,f);
[v,f] = hexMesh; c = meshFrechet(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
[v,f] = hexMesh; v(:,1) = v(:,1) + 10*(v(:,1)>=10); c = meshFrechet(v,f); figure; patchvfc(v,f); hold on; scatter(v(c,1),v(c,2));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

