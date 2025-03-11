---
layout: default
title: ndims1
checksum: afec4c0ed2c727dfb5ad060b05bd4054
parent: sugar
---


 
# NDIMS1 Number of array dimensions, with possibly 0 or 1 dimensions
 
# Syntax
```matlab
N = ndims1(A)
```
 
# Description

`N = ndims(A)` returns the number of dimensions in the array A. The function ignores trailing dimensions, for which `size(A,dim) = 0` or `size(A,dim) = 1`.

 
# Examples
```matlab
ndims1(magic(5))
ndims1(1:5)
ndims1((1:5)')
ndims1([])
```
 
# Input Arguments

`A - input array (scalar | vector | matrix)`

 
# See Also

`SIZE`, `LENGTH`, `NDIMS`

 
# Authors

Mehul Gajwani, Monash University, 2024

