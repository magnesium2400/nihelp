---
layout: default
title: decreaseRegularPatch
checksum: b2b110559de0703806a91bb11b5da3a7
parent: meshes
---


 
# DECREASEREGULARPATCH Combines triangles of mesh derived by upsampling regular mesh
 
# Usage Notes
-  Here, a "regular" mesh refers to a mesh derived from upsampling an (equilateral) triangular mesh (see `decreaseRegularPatch_test.m` for some examples). This will reverse that upsampling. 
-  The algorithm used in this function performs an exact subsampling/downsampling of the original surface. In particular, it starts with a set of seed points, and then moves exactly `stepSize` steps away, and adds those points to the downsampled surface. It will do this recursively, up to `stepIter` times, or until no new points are added to the downsampled surface. Note that the initial seed points are the vertices which are not connected to exactly six neighbours. Therefore, this function is well-suited to recovering icosahedral/octahedral meshes (5/4 triangles meeting at each vertex), but not meshes derived from a cube or gyroelongated triangular bipyramid (as there are still six triangles meeting at each vertex). 
-  For example, the fsLR_32k surface is derived from an icosahedral mesh where each faces is split into 57^2=3249 faces (hence why it has 64980 faces). This function can convert it back to an icosahedron (e.g. `[v2,f2] = decreaseRegularPatch(fsLR_faces, 57, [], fsLR_verts)`). 
-  As this function performs **exact** downsampling/subsampling, it can also be used to downsample by a factor of 3 or 19 (e.g. `[v2,f2] = decreaseRegularPatch(fsLR_faces, 3, [], fsLR_verts)`) but not other factors like 2, 4, or 18. 
-  For a mesh with `F` faces that is an upsampled version of a mesh with `f` faces, consider using `factorall(sqrt(F/f))` to see the options possible for `stepSize` in this function. 
 
# Timings for downsampling to icosahedron

(* faces --> 20 faces)

```matlab
| Factor | Vertices | Faces  | Time (s) |
| :----: | :------: | :----: | :------: |
| 2      | 42       | 80     | 0.0028   |
| 4      | 162      | 320    | 0.0030   |
| 8      | 642      | 1280   | 0.0039   |
| 16     | 2562     | 5120   | 0.0077   |
| 32     | 10242    | 20480  | 0.0299   |
| 64     | 40962    | 81920  | 0.2684   |
| 128    | 163842   | 327680 | 2.2817   |
```
 
# Examples

See `decreaseRegularPatch_test.m` for examples

 
# TODO
-  docs 
-  add sparse matrix that maps values from v to vn (i.e. height(vn)*height(v) ) 
-  add ability to choose original seed points? 
 
# See also

`increasePatch`, `equilateralMesh`

 
# Authors

Mehul Gajwani, Monash University, 2024

