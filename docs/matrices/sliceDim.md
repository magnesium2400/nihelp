---
layout: default
title: sliceDim
checksum: 128cfb7172a31fd783df7f918bfb9455
parent: matrices
---


 
# SLICEDIM extract the n-th slice from the d-th dimension of volume V
 
# Examples
```matlab
sliceDim(magic(3),1,1)
V = magic(5)+permute([0 0 0],[1 3 2]); sliceDim(V,1,1)
V = magic(5)+permute([0 0 0],[1 3 2]); sliceDim(V,2,[1,2])
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

