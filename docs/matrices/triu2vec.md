---
layout: default
title: triu2vec
checksum: 9888c02db62f619c51efeba18d79b0b0
parent: matrices
---


 
# TRIU2VEC Extract upper triangular part and convert to column vector
 
# Usage Notes

Returns data from upper triangle of A, moving down the columns. If you want the same data, but in row-major order, use something like: `flip(triu2vec(fliplr(flipud(A.'))))` or `tril2vec(A.')`.

 
# Examples
```matlab
triu2vec(magic(3))
triu2vec(magic(3),1)
triu2vec(magic(3),-1,true)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

