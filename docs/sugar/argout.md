---
layout: default
title: argout
checksum: 24e386cb62f6503f995c3fe2466a7c3b
parent: sugar
---


 
# ARGOUT Return n-th output from a function
 
# Input Arguments

`f - function to get argument from (function handle)` Should not have any inputs. May be a good idea to input as an anonymous function of the desired computation (see examples).


`n - argument position to return (positive integer)`


`m - number of outputs to request when calling f (positive integer)` default is `n`.

 
# Examples
```matlab
argout(@() max(magic(3)), 2)
argout(@() unique(magic(3)), 3)
argout(@() eig(magic(3)), 1, 2)
```
 
# Authors

Mehul Gajwani, Monash University, 2024

