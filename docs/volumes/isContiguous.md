---
layout: default
title: isContiguous
checksum: ccf19c5e09ab43fe0b2a99a48af2d5b6
parent: volumes
---


 
# ISCONTIGUOUS Compute whether all points in a volumetric region are connected
 
# Examples
```matlab
isContiguous(magic(4)>4)
isContiguous(magic(4)>5)
isContiguous(magic(4)>5, sqrt(2))
isContiguous(cat(3, magic(2)==1, magic(2)==2))
isContiguous(cat(3, magic(2)==1, magic(2)==2), sqrt(2))
isContiguous(cat(3, magic(2)==1, magic(2)==2), sqrt(3))
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

