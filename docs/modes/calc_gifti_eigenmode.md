---
layout: default
title: calc_gifti_eigenmode
checksum: 20435fc5d242cc9d0e8aa5c689708a20
parent: modes
---


 
# CALC_GIFTI_EIGENMODE Calculate surface eigenmodes
 
# Dependencies

GIfTI Library found here: github.com/gllmflndn/gifti (download and add to path)

 
# Inputs
```matlab
`giftipath - path to gifti (string | char array)`
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
`giftiModes - array of eigenmodes (matrix)`
```
```matlab
`s - struct containing eigenmodes, mass matrix, verts, etc. (struct)`
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

