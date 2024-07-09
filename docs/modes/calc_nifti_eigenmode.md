---
layout: default
title: calc_nifti_eigenmode
checksum: 8e3686ed58ca1c54f05c35b5086b54c2
parent: modes
---


 
# CALC_NIFTI_EIGENMODE Calculate volumetric eigenmodes
 
# Inputs
```matlab
`niftipath - path to nifti (string | char array)`
```
```matlab
`k - number of eigenmodes (positive integer scalar)`
```
```matlab
`sigma - approximation of first eigenvalue (scalar)`
```
```matlab
`lump - flag to lump mass matrix (false (default) | true)`
```
 
# Outputs
```matlab
`niftiModes - array of eigenmodes (matrix)`
```
```matlab
`s - struct containing eigenmodes, mass matrix, verts, etc. (struct)`
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

