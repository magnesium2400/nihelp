---
layout: default
title: invsort
checksum: 9d5383808aa98e00ed20c471d21fa04c
parent: matrices
---


 
# INVSORT Find the reverse of a sort order (inverse of permutation vector)
 
# Examples
```matlab
invsort([5 1 3 4 2])
a = [5 1 3 4 2]; a(invsort(a))
a = [50 10 30 40 20]; a(invsort(a))
a = magic(3), b = [2 3 1]; c = a(:,b), c(:, invsort(b))
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

