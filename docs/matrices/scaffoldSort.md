---
layout: default
title: scaffoldSort
checksum: 14499584b896fee290e2d2218e00dc0a
parent: matrices
---


 
# SCAFFOLDSORT Reorder data according to a provided scaffold
 
# Examples
```matlab
scaffoldSort([10 50 30 20], [6 8 7 9])
scaffoldSort([10 50 30 20], [4 3 2 1])
scaffoldSort([4 3 2 1], [10 50 30 20])
x = rand(99,1); y = rand(numel(x), 1); figure; scatter(x,scaffoldSort(y,x),[],(1:numel(x))');
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

