---
layout: default
title: factorall
checksum: 6bff4120e98bc8766bca30bca684e1eb
parent: maths
---


 
# FACTORALL Return a row vector containing all the factors of a positive integer
 
# Examples
```matlab
factorall(6)
for ii = [2,3,5,7,11,13];  assert(sum(factorall(ii))==1+ii); end
for ii = [6,28,496,8128];  assert(sum(factorall(ii))==2*ii); end
for ii = [120,672,523776]; assert(sum(factorall(ii))==3*ii); end
```
 
# TODO
-  docs 
 
# See Also
```matlab
FACTOR
```
 
# Authors

Mehul Gajwani, Monash University, 2024

