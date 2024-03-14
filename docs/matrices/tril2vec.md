---
layout: default
title: tril2vec
checksum: 8f0d09afad8ad8d2c77da13659210b23
parent: matrices
---


 
# TRIL2VEC Extract lower triangular part and convert to column vector
 
# Usage Notes

Returns data from lower triangle of A, moving down the columns. If you want the same data, but in row-major order, use something like: `flip(tril2vec(fliplr(flipud(A.'))))` or `triu2vec(A.')`.

 
# Examples
```matlab
tril2vec(magic(3))
tril2vec(magic(3),-1)
tril2vec(magic(3),1,true)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

