---
layout: default
title: renumber
checksum: c95216fbd4b4e29d4a0983deb7a4174f
parent: matrices
---


 
# RENUMBER Replace values in matrix
 
# Examples
```matlab
renumber(eye(3), 2)
renumber(eye(3), 2, 0)
renumber(eye(3), 2, 1)
renumber(eye(3), 2, [0 1])
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

