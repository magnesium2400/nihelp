---
layout: default
title: resampleMatrix
checksum: 2f4a48f70c27901f3ca8d6c4c9a66a1e
parent: matrices
---


 
# RESAMPLEMATRIX Generates a matrix of noise in the same pattern as a template
 
# Examples
```matlab
resampleMatrix(magic(4))
t = magic(20); n = resampleMatrix(t); figure; scatter(t(:),n(:));
t = magic(10).*(magic(10)>50); n = resampleMatrix(t); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
t = magic(10).*(magic(10)>50); n = resampleMatrix(t,'randParams',[0.5 0.1]); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
t = log(pascal(15)).*(pascal(15)<500); n = resampleMatrix(t,'uniform','seed',314159,'randParams',[1,10],'resymmetrise',1,'ignoreRepeats',1,'resetZeros',1); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
t = log(pascal(15)).*(pascal(15)<500); n = resampleMatrix(t,'uniform','seed',314159,'randParams',[-1,1],'resymmetrise',0,'ignoreRepeats',0,'resetZeros',0); figure; nexttile; imagesc(t); nexttile; imagesc(n); nexttile; scatter(t(:),n(:));
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

