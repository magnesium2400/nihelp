---
layout: default
title: trimVolume
checksum: 8d5fb5385beac55a5e079a1450e457b6
parent: volumes
---


 
# TRIMVOLUME Trim volumetric data e.g. to its bounding box (with optional buffer)
 
# Examples
```matlab
V = zeros(4,4,4); V([22,23,26,27,38,39,42,43]) = 1; figure; nexttile; plotVolume(V); nexttile; plotVolume(trimVolume(V));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

