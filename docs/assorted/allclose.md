---
layout: default
title: allclose
checksum: e925951c3a2e7ed78b5aa9d751b8c474
parent: assorted
---


 
# ALLCLOSE Checks whether all values are close to each other, or not
 
# Examples
```matlab
allclose((1:10)+1e-9, (1:10)+1e-10)
allclose((1:10)+1e-9, (1:10)-1e-10)
allclose((1:10)+1e-9, (1:10)-1e-10, 2e-9)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

