---
layout: default
title: isContiguous
checksum: 71c039259b0513c8dcd82d127e1f9872
parent: volumes
---


 
# ISCONTIGUOUS Compute whether all points in a volumetric region are connected
 
# Examples
```matlab
isContiguous(magic(4)>4)
isContiguous(magic(4)>5)
isContiguous(magic(4)>5, sqrt(2))
isContiguous(cat(3, pascal(3)<3, pascal(3)>3))
isContiguous(cat(3, pascal(3)<3, pascal(3)>3), sqrt(2))
isContiguous(cat(3, pascal(3)<3, pascal(3)>3), sqrt(3))
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

