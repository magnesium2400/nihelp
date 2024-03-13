---
layout: default
title: vec2triu
checksum: 8039f7220570d89d05cc04df07acc699
parent: matrices
---


 
# VEC2TRIU Convert vectorised data to upper triangle of a matrix
 
# Examples
```matlab
vec2triu(1:6) % expected warning
vec2triu(1:10,3)
vec2triu(1:15,0,true)
triu2vec(vec2triu(1:6,5),5)
vec2triu(triu2vec(magic(5),2),2)
vec2triu(triu2vec(magic(7),-3,true),-3,true)
triu2vec(vec2triu(1:22,-2,1),-2,1)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# SEE ALSO

SQUAREFORM

