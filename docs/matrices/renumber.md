---
layout: default
title: renumber
checksum: b5a2cc48c12158ab3c550ed6b22b0057
parent: matrices
---


 
# RENUMBER Replace values in matrix
 
# Examples
```matlab
renumber(eye(3), 2)
renumber(eye(3), 2, 1)
renumber(magic(3), 10, 1)
renumber(magic(3), 10:20:90, 1:2:9)
renumber(magic(4), 10*(1:16), 1:16)
renumber(magic(3)+cat(3,0,1,2,3), 10*(1:12), 1:12)
```
 
# TODO
-  docs 
 
# See Also
```matlab
CHANGEM
```
 
# Authors

Mehul Gajwani, Monash University, 2024

