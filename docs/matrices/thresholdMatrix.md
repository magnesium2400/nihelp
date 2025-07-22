---
layout: default
title: thresholdMatrix
checksum: ea8cad0681157898f63ae94bb4c8e892
parent: matrices
---


 
# THRESHOLDMATRIX Threshold matrix according to density, nnx, max, or min
 
# Examples
```matlab
thresholdMatrix(magic(4), 'nnz', 5)      % keep the 5 largest non-zero terms
thresholdMatrix(magic(4), 'density', .5) % keep the largest terms s.t density is .5
thresholdMatrix(hilb(3), 'density', .5)
thresholdMatrix(hilb(3), 'density', .5, 'inclusive', false)
thresholdMatrix(hilb(3), 'max', .5)
thresholdMatrix(hilb(3), 'max', .5, 'inclusive', false)
thresholdMatrix(hilb(3), 'min', .5)
thresholdMatrix(hilb(3), 'min', .5, 'newValue', 0)
thresholdMatrix(hilb(3), 'max', .5, 'min', 0.3)
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

