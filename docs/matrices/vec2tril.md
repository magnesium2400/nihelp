---
layout: default
title: vec2tril
checksum: e37b2401a4a26b7a16017165efc38514
parent: matrices
---


 
# VEC2TRIL Convert vectorised data to lower triangle of a matrix
 
# Examples
```matlab
vec2tril(1:6) % expected warning
vec2tril(1:10,-3)
vec2tril(1:15,0,true)
tril2vec(vec2tril(1:6,-5),-5)
vec2tril(tril2vec(magic(5),-2),-2)
vec2tril(tril2vec(magic(7),3,true),3,true)
tril2vec(vec2tril(1:22,2,1),2,1)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# SEE ALSO

SQUAREFORM

