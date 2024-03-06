---
layout: default
title: vol2xyz
checksum: c4720c984ae863fcba437f36dda055ae
parent: volumes
---


 
# vol2xyz Volumetric data in voxel coordinates to xyz coordinates
 
# Examples
```matlab
coords = vol2xyz(loadmri)
coords = vol2xyz(loadmri, logical(loadmri)); figure; scat3(coords);
[coords, data] = vol2xyz(loadmri, logical(loadmri)); figure; scat3(coords, [], data);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

