---
layout: default
title: xyz2vol
checksum: f7ae3e99ae6cb94792a26e56e61a730f
parent: volumes
---


 
# XYZ2VOL Converts xyz volumetric coordinates to 3-D volume
 
# Examples
```matlab
xyz = [1 1 1; 1 1 2; 1 2 1; 2 1 1]; V = xyz2vol(xyz);
xyz = table2array(combinations(1:3,1:3,1:3)); V = xyz2vol(xyz);
xyz = table2array(combinations(2:3,2:3,2:3)); V = xyz2vol(xyz,1:8,0,[4 4 4]);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

