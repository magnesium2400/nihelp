---
layout: default
title: separatePatches
checksum: 70b76ec745c3f929f80793735fa5c80f
parent: meshes
---


 
# SEPARATEPATCHES Separates verts and faces into two distinct patches
 
# Examples
```matlab
[v,f] = sphereMesh; [v1,f1,v2,f2]=separatePatches(v,f); p=@(a,b) patch('Vertices',a,'Faces',b,'FaceColor','none'); figure; p(v1,f1); hold on; p(v2,f2);
[v,f] = torusMesh; [v1,f1,v2,f2]=separatePatches(v,f,[],'SeparatingFunction',@(x) x(:,1).^2+x(:,2).^2<2); p=@(a,b,c) patch('Vertices',a,'Faces',b,'FaceColor',c); figure; p(v1,f1,'blue'); p(v2,f2,'red');
[v,f] = sphereMesh; r=randi(2,size(v(:,1))); [v1,f1,v2,f2]=separatePatches(v,f,r,r<2); p=@(a,b,c) patch('Vertices',a,'Faces',b,'FaceColor',c); figure; nexttile; p(v1,f1,'blue'); nexttile; p(v2,f2,'red');
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

