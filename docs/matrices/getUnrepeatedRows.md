---
layout: default
title: getUnrepeatedRows
checksum: 239296776481b127dd32057402e70906
parent: matrices
---


 
# GETUNREPEATEDROWS Gets rows which occur exactly once in a matrix
 
# Examples
```matlab
getUnrepeatedRows([1 2 3; 4 5 6; 1 2 3])
[a,m] = getUnrepeatedRows([1 2 3; 4 5 6; 1 2 3])
[a,m] = getUnrepeatedRows([1 2 3; 7 8 9; 4 5 6; 1 2 3])
getUnrepeatedRows([1 2 3; 1 2 3; 4 5 6; 4 5 6])
getUnrepeatedRows(kron([1;1;2],eye(3)))
v = rand(100,2); f = delaunay(v); e = getUnrepeatedRows(sort(decreaseSimplexDimension(f),2)); figure; plotLines(v(e(:,1),:),v(e(:,2),:));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

