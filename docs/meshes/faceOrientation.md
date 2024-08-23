---
layout: default
title: faceOrientation
checksum: fbca7d93f5bb41610e081fa885a5af93
parent: meshes
---


 
# FACEORIENTATION Finds the relative orientation of each face in triangulation
 
# Examples
```matlab
v=rand(100,2); f=delaunay(v); fo = faceOrientation(f); assert(all(fo==1));
See `faceOrientation_test.m` for more examples.
```
 
# Usage Notes

For an input triangulation of `f` faces, the output will be an `f x 1` vector containing positive and negative integer values. Each integer is associated with one component. Positive values indicate that that face has the same relative orientation as the 'first' face in that component (where first means appearing first in the input matrix); negative values indicate the opposite orientation.

 
## Timings
```matlab
| Faces  | Time (s) |
| :---:  | :------: |
| 20     | 0.001240 |
| 80     | 0.002013 |
| 320    | 0.006903 |
| 1280   | 0.025448 |
| 5120   | 0.101284 |
| 20480  | 0.384685 |
| 81920  | 1.759828 |
| 327680 | 7.711887 |
```
 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

