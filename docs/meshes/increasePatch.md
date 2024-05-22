---
layout: default
title: increasePatch
checksum: a2d5b360a7728af50f8387851d0cf136
parent: meshes
---


 
# INCREASE PATCH Splits each triangle in surface mesh into 4 congruent triangles
 
# Examples
```matlab
[v,f] = increasePatch(eye(3),1:3)
v = eye(3); f = 1:3; t = @(v,f,c) trimesh(f,v(:,1),v(:,2),v(:,3),c{:}); figure; t(v,f); [v,f] = increasePatch(v,f); hold on; t(v,f);
v = [1 3 0; 1 2 0; 2 2 0; 1 1 0; 2 1 0; 3 1 0]; f = [1 2 3; 2 4 5; 3 2 5; 3 5 6]; [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);
[v,f] = cuboidSurface(2,3,4); [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);
[v,f] = torusMesh; [v2,f2] = increasePatch(v,f); figure; plotSkeleton(v,f,'patchOptions', {'LineStyle', '--', 'FaceAlpha', 0,'LineWidth',2}); hold on; plotSkeleton(v2,f2);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

