---
layout: default
title: increasePatch
checksum: 9d94fcb6617e3280f1f24994c5df3fe9
parent: meshes
---


 
# INCREASEPATCH Increases patch resolution (subdivides triangles) by any factor
 
# Timings for upsampling icosahedron (20 faces --> * faces)
```matlab
| Factor | Vertices | Faces  | Time (s) |
| :----: | :------: | :----: | :------: |
| 2      | 42       | 80     | 0.0047   |
| 4      | 162      | 320    | 0.0047   |
| 8      | 642      | 1280   | 0.0037   |
| 16     | 2562     | 5120   | 0.0076   |
| 32     | 10242    | 20480  | 0.1227   |
| 64     | 40962    | 81920  | 1.3347   |
| 128    | 163842   | 327680 | 18.6262  |
```
 
# Examples

See `increasePatch_test.m` for examples

 
# TODO
-  docs 
 
# See also

`decreaseRegularPatch`, `equilateralMesh`

 
# Authors

Mehul Gajwani, Monash University, 2024

