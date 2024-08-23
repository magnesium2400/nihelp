---
layout: default
title: idx2mask
checksum: a1b76cabfa99017dd8b4618b5744625e
parent: sugar
---


 
# IDX2MASK Converts indices to logical mask
 
# Examples
```matlab
a = [1 2 5 9]; b = idx2mask(a);
a = [1 2 5 9]; b = idx2mask(a, 10);
rng(1); a=rand(99,1)>0.5; b=find(a); c=idx2mask(b,99); assert(isequal(a,c));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

