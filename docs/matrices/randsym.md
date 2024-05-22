---
layout: default
title: randsym
checksum: b21ba1469a9426b5b54045aa36e361ce
parent: matrices
---


 
# RANDSYM Random symmetric uniform matrix of specified size and density
 
# Examples
```matlab
randsym(10)
W = randsym(1000,0.3); nnz(tril(W,-1))*2/length(W)/(length(W)-1), issymmetric(W), figure; nexttile; imagesc(W); nexttile; histogram(nonzeros(W),0:0.1:1);
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

