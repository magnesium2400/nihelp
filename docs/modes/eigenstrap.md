---
layout: default
title: eigenstrap
checksum: 6f10dfef3f901a3aaab35a7e4c2b6877
parent: modes
---


 
# EIGENSTRAP applies the eigenstrapping of Koussis & Breakspear to mode data
 
# Inputs

`modeData - eigenmodes (nPoints x nModes matrix)`


`mask (optional) - mask to be applied to mode (nPoints x 1 logical vector)`

 
# Outputs

`modeStrap - modes with each group rotated in eigenspace (nPoints x nModes matrix)` Note that any points not specifeid by `mask` will retain their original values.

 
# See also

eigenstrapSubgroup, sorthogonal

 
# Authors

Mehul Gajwani, Monash University, 2023

