---
layout: default
title: joinParcs
checksum: 20edbfe63228d1779a9a093ad0c568a7
parent: meshes
---


 
# JOINPARCS Re-indexes ROI allocations from two surfaces/hemispheres into 1
 
# Examples
```matlab
l = randi(11,[100,1])-1; r = randi(11,[100,1])-1; lr = joinParcs(l, r); figure; nexttile; plot(l); nexttile; plot(r); nexttile([1,2]); plot(lr);
lAndr = randi(11,[400,1])-1; figure; nexttile; plot(lAndr); nexttile; plot(joinParcs(lAndr));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

